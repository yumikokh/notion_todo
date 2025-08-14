import '../../notion/model/property.dart';
import '../../notion/model/task.dart';
import '../../notion/model/task_database.dart';

/// NotionのAPIレスポンスからモデルオブジェクトに変換するためのユーティリティクラス
class NotionConverter {
  /// プロパティをIDで検索する共通関数
  static Map<String, dynamic>? findPropertyById(
      Map<String, dynamic> data, String propertyId) {
    try {
      return (data['properties'] as Map<String, dynamic>)
          .entries
          .where((entry) => entry.value['id'] == propertyId)
          .map((entry) => entry.value)
          .firstOrNull;
    } catch (e) {
      print('Error finding property by id: $e');
      return null;
    }
  }

  /// タイトルプロパティからテキストを抽出する
  static String extractTitle(
      Map<String, dynamic> data, TaskDatabase taskDatabase) {
    // titleプロパティは常にidが"title"
    final titleProperty = findPropertyById(data, 'title')?['title'];
    return titleProperty?.length > 0 ? titleProperty[0]['plain_text'] : '';
  }

  /// 日付プロパティからTaskDateオブジェクトを抽出する
  static TaskDate? extractDate(
      Map<String, dynamic> data, TaskDatabase taskDatabase) {
    final dateProperty = findPropertyById(data, taskDatabase.date.id);
    if (dateProperty == null) {
      return null;
    }
    final date = dateProperty['date'];
    if (date == null) {
      return null;
    }
    return TaskDate(
      start: NotionDateTime.fromString(date['start']),
      end: date['end'] != null ? NotionDateTime.fromString(date['end']) : null,
    );
  }

  /// ステータスプロパティからTaskStatusオブジェクトを抽出する
  static TaskStatus extractStatus(
      Map<String, dynamic> data, TaskDatabase taskDatabase) {
    final property = taskDatabase.status;
    final statusData = findPropertyById(data, property.id);
    if (statusData == null) {
      return const TaskStatus.status(group: null, option: null);
    }

    switch (property) {
      case CheckboxCompleteStatusProperty():
        return TaskStatus.checkbox(checkbox: statusData['checkbox']);
      case StatusCompleteStatusProperty(status: var status):
        // statusが未指定の場合がある
        if (statusData['status'] == null) {
          return const TaskStatus.status(group: null, option: null);
        }

        final optionId = statusData['status']['id'];
        final group = status.groups
            .where((group) => group.optionIds.contains(optionId))
            .firstOrNull;
        final option =
            status.options.where((option) => option.id == optionId).firstOrNull;

        return TaskStatus.status(group: group, option: option);
    }
  }

  /// 優先度プロパティからSelectOptionオブジェクトを抽出する
  static SelectOption? extractPriority(
      Map<String, dynamic> data, TaskDatabase taskDatabase) {
    final property = taskDatabase.priority;
    if (property == null) {
      return null;
    }
    final propertyData = findPropertyById(data, property.id);
    if (propertyData == null || propertyData['select'] == null) {
      return null;
    }
    final selectData = propertyData['select'];

    return SelectOption(
      id: selectData['id'],
      name: selectData['name'],
      color: NotionColor.fromString(selectData['color']),
    );
  }

  /// プロジェクトプロパティからRelationOptionのリストを抽出する
  static List<RelationOption>? extractProject(
      Map<String, dynamic> data, TaskDatabase taskDatabase) {
    final property = taskDatabase.project;
    if (property == null) {
      return null;
    }
    final propertyData = findPropertyById(data, property.id);
    if (propertyData == null || propertyData['relation'] == null) {
      return null;
    }
    final relationData = propertyData['relation'] as List;

    return relationData.map((item) {
      return RelationOption(
        id: item['id'],
        title: item['title']?[0]?['plain_text'],
        icon: null,
      );
    }).toList();
  }

  /// その他の追加プロパティを抽出する
  static Map<String, dynamic>? extractAdditionalFields(
      Map<String, dynamic> data, TaskDatabase taskDatabase) {
    final additionalProperties = taskDatabase.additionalProperties;
    if (additionalProperties == null || additionalProperties.isEmpty) {
      return null;
    }

    final result = <String, dynamic>{};

    for (final entry in additionalProperties.entries) {
      final propertyId = entry.key;
      final property = entry.value;

      final propertyData = findPropertyById(data, property.id);
      if (propertyData != null) {
        // プロパティタイプに応じて値を抽出
        final value = _extractPropertyValue(propertyData, property);
        if (value != null) {
          result[propertyId] = value;
        }
      }
    }

    return result.isEmpty ? null : result;
  }

  /// プロパティタイプに応じて値を抽出するヘルパーメソッド
  static dynamic _extractPropertyValue(
      Map<String, dynamic> propertyData, Property property) {
    switch (property.type) {
      case PropertyType.relation:
        if (propertyData['relation'] != null) {
          final relationData = propertyData['relation'] as List;
          return relationData.map((item) {
            return RelationOption(
              id: item['id'],
              title: null, // Notion APIではrelationのタイトルは含まれない
              icon: null,
            );
          }).toList();
        }
        break;
      case PropertyType.select:
        if (propertyData['select'] != null) {
          final selectData = propertyData['select'];
          return SelectOption(
            id: selectData['id'],
            name: selectData['name'],
            color: NotionColor.fromString(selectData['color']),
          );
        }
        break;
      case PropertyType.checkbox:
        return propertyData['checkbox'];
      case PropertyType.number:
        return propertyData['number'];
      case PropertyType.url:
        return propertyData['url'];
      case PropertyType.formula:
        return propertyData['formula']?['string'] ??
            propertyData['formula']?['number'];
      case PropertyType.multiSelect:
        if (propertyData['multi_select'] != null) {
          final multiSelectData = propertyData['multi_select'] as List;
          return multiSelectData.map((item) {
            return SelectOption(
              id: item['id'],
              name: item['name'],
              color: NotionColor.fromString(item['color']),
            );
          }).toList();
        }
        break;
      case PropertyType.date:
        final date = propertyData['date'];
        if (date != null) {
          return TaskDate(
            start: NotionDateTime.fromString(date['start']),
            end: date['end'] != null
                ? NotionDateTime.fromString(date['end'])
                : null,
          );
        }
        break;
      default:
        // その他のプロパティタイプは生の値を返す
        return propertyData[property.type.name];
    }
    return null;
  }

  /// APIレスポンスをTaskオブジェクトのリストに変換する
  static List<Task> convertToTasks(
      Map<String, dynamic> result, TaskDatabase taskDatabase) {
    return (result['results'] as List)
        .map((page) => createTaskFromData(page, taskDatabase))
        .toList();
  }

  /// レスポンスデータからTaskオブジェクトを作成するヘルパーメソッド
  static Task createTaskFromData(
      Map<String, dynamic> data, TaskDatabase taskDatabase) {
    return Task(
      id: data['id'],
      title: NotionConverter.extractTitle(data, taskDatabase),
      status: NotionConverter.extractStatus(data, taskDatabase),
      dueDate: NotionConverter.extractDate(data, taskDatabase),
      url: data['url'],
      icon: data['icon']?['emoji'] ?? data['icon']?['external']?['url'],
      priority: NotionConverter.extractPriority(data, taskDatabase),
      projects: NotionConverter.extractProject(data, taskDatabase),
      additionalFields:
          NotionConverter.extractAdditionalFields(data, taskDatabase),
    );
  }
}
