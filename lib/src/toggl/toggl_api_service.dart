import 'dart:convert';
import 'package:http/http.dart' as http;

class TogglApiService {
  static const String _baseUrl = 'https://api.track.toggl.com/api/v9';
  
  final String apiToken;
  final int workspaceId;
  
  TogglApiService({
    required this.apiToken,
    required this.workspaceId,
  });

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Basic ${base64Encode(utf8.encode('$apiToken:api_token'))}',
  };

  /// プロジェクト一覧を取得
  Future<List<TogglProject>> getProjects() async {
    final url = Uri.parse('$_baseUrl/workspaces/$workspaceId/projects');
    
    try {
      final response = await http.get(url, headers: _headers);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((project) => TogglProject.fromJson(project)).toList();
      } else {
        throw TogglApiException('Failed to get projects: ${response.statusCode}');
      }
    } catch (e) {
      throw TogglApiException('Error getting projects: $e');
    }
  }

  /// タイムエントリーを開始
  Future<TogglTimeEntry> startTimeEntry({
    required String description,
    int? projectId,
    List<String>? tags,
  }) async {
    final url = Uri.parse('$_baseUrl/workspaces/$workspaceId/time_entries');
    
    final body = {
      'description': description,
      'start': DateTime.now().toUtc().toIso8601String(),
      'duration': -1, // 進行中のタイマーは-1
      'workspace_id': workspaceId,
      'created_with': 'notion_todo_app',
      if (projectId != null) 'project_id': projectId,
      if (tags != null && tags.isNotEmpty) 'tags': tags,
    };
    
    try {
      final response = await http.post(
        url,
        headers: _headers,
        body: json.encode(body),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return TogglTimeEntry.fromJson(data);
      } else {
        throw TogglApiException('Failed to start time entry: ${response.statusCode}');
      }
    } catch (e) {
      throw TogglApiException('Error starting time entry: $e');
    }
  }

  /// 現在実行中のタイムエントリーを取得
  Future<TogglTimeEntry?> getCurrentTimeEntry() async {
    final url = Uri.parse('$_baseUrl/me/time_entries/current');
    
    try {
      final response = await http.get(url, headers: _headers);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null) {
          return TogglTimeEntry.fromJson(data);
        }
        return null;
      } else if (response.statusCode == 404) {
        // 現在実行中のタイマーがない場合
        return null;
      } else {
        throw TogglApiException('Failed to get current time entry: ${response.statusCode}');
      }
    } catch (e) {
      throw TogglApiException('Error getting current time entry: $e');
    }
  }

  /// タイムエントリーを停止
  Future<TogglTimeEntry> stopTimeEntry(int timeEntryId) async {
    final url = Uri.parse('$_baseUrl/workspaces/$workspaceId/time_entries/$timeEntryId/stop');
    
    try {
      final response = await http.patch(url, headers: _headers);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return TogglTimeEntry.fromJson(data);
      } else {
        throw TogglApiException('Failed to stop time entry: ${response.statusCode}');
      }
    } catch (e) {
      throw TogglApiException('Error stopping time entry: $e');
    }
  }

  /// ワークスペース情報を取得
  Future<List<TogglWorkspace>> getWorkspaces() async {
    final url = Uri.parse('$_baseUrl/workspaces');
    
    try {
      final response = await http.get(url, headers: _headers);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((workspace) => TogglWorkspace.fromJson(workspace)).toList();
      } else {
        throw TogglApiException('Failed to get workspaces: ${response.statusCode}');
      }
    } catch (e) {
      throw TogglApiException('Error getting workspaces: $e');
    }
  }
}

// データクラス
class TogglTimeEntry {
  final int id;
  final String description;
  final DateTime start;
  final DateTime? stop;
  final int duration;
  final int workspaceId;
  final int? projectId;

  const TogglTimeEntry({
    required this.id,
    required this.description,
    required this.start,
    this.stop,
    required this.duration,
    required this.workspaceId,
    this.projectId,
  });

  factory TogglTimeEntry.fromJson(Map<String, dynamic> json) {
    return TogglTimeEntry(
      id: json['id'],
      description: json['description'] ?? '',
      start: DateTime.parse(json['start']),
      stop: json['stop'] != null ? DateTime.parse(json['stop']) : null,
      duration: json['duration'],
      workspaceId: json['workspace_id'],
      projectId: json['project_id'],
    );
  }

  bool get isRunning => duration < 0;
}

class TogglProject {
  final int id;
  final String name;
  final String? color;
  final int workspaceId;

  const TogglProject({
    required this.id,
    required this.name,
    this.color,
    required this.workspaceId,
  });

  factory TogglProject.fromJson(Map<String, dynamic> json) {
    return TogglProject(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      workspaceId: json['workspace_id'],
    );
  }
}

class TogglWorkspace {
  final int id;
  final String name;

  const TogglWorkspace({
    required this.id,
    required this.name,
  });

  factory TogglWorkspace.fromJson(Map<String, dynamic> json) {
    return TogglWorkspace(
      id: json['id'],
      name: json['name'],
    );
  }
}

class TogglApiException implements Exception {
  final String message;
  
  const TogglApiException(this.message);
  
  @override
  String toString() => 'TogglApiException: $message';
}