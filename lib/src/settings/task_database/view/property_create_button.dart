import 'package:flutter/material.dart';

import '../../../notion/repository/notion_database_repository.dart';
import '../selected_database_viewmodel.dart';

class PropertyCreateButton extends StatelessWidget {
  const PropertyCreateButton({
    super.key,
    required this.type,
    required this.selectedDatabaseViewModel,
    required this.onDatabaseRefreshed,
  });
  final CreatePropertyType type;
  final SelectedDatabaseViewModel selectedDatabaseViewModel;
  final Future<void> Function() onDatabaseRefreshed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final propertyName = await showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            String tempName = '';
            return AlertDialog(
              content: TextField(
                onChanged: (value) {
                  tempName = value;
                },
                decoration: const InputDecoration(
                  hintText: 'プロパティ名',
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('キャンセル'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(tempName);
                  },
                  child: const Text('確定'),
                ),
              ],
            );
          },
        );

        if (propertyName != null) {
          final property = await selectedDatabaseViewModel.createProperty(
              type, propertyName);

          // データベースが再取得されるまで待つ
          await onDatabaseRefreshed();

          final propertyType = switch (type) {
            CreatePropertyType.date => SettingPropertyType.date,
            CreatePropertyType.checkbox => SettingPropertyType.status
          };

          selectedDatabaseViewModel.selectProperty(property.id, propertyType);
        }
      },
      child: const Text('新規作成'),
    );
  }
}