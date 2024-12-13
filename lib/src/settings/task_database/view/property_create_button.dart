import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final l = AppLocalizations.of(context)!;
    return SizedBox(
      height: 30,
      child: FilledButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
          ),
        ),
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
                  decoration: InputDecoration(
                    hintText: l.property_name,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(l.cancel),
                  ),
                  FilledButton(
                    onPressed: () async {
                      final errorMessage = tempName.trim().isEmpty
                          ? l.property_name_input
                          : await selectedDatabaseViewModel
                                  .checkPropertyExists(tempName)
                              ? l.property_name_error
                              : null;
                      if (errorMessage != null) {
                        showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(l.error),
                              content: Text(errorMessage),
                              actions: [
                                FilledButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(l.ok),
                                ),
                              ],
                            );
                          },
                        );
                        return;
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop(tempName);
                    },
                    child: Text(l.confirm),
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
        child: Text(l.new_create, style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}
