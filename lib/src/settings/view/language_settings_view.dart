import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSettingsView extends StatelessWidget {
  static const routeName = '/settings/language';

  const LanguageSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.language_settings_title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(l.language_settings_language_ja),
              leading: Radio<Locale>(
                value: const Locale('ja'),
                groupValue: Localizations.localeOf(context),
                onChanged: (Locale? newLocale) {
                  if (newLocale != null) {
                    // TODO: 言語設定の更新処理
                  }
                },
              ),
            ),
            ListTile(
              title: Text(l.language_settings_language_en),
              leading: Radio<Locale>(
                value: const Locale('en'),
                groupValue: Localizations.localeOf(context),
                onChanged: (Locale? newLocale) {
                  if (newLocale != null) {
                    // TODO: 言語設定の更新処理
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
