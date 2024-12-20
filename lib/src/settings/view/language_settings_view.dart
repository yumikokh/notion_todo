import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings_viewmodel.dart';

class LanguageSettingsView extends ConsumerWidget {
  static const routeName = '/settings/language';

  const LanguageSettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final viewModel = ref.read(settingsViewModelProvider.notifier);
    final languages = [
      (name: l.language_settings_language_ja, locale: const Locale('ja')),
      (name: l.language_settings_language_en, locale: const Locale('en')),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l.language_settings_title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final language in languages)
              ListTile(
                title: Text(language.name),
                leading: Radio<Locale>(
                  value: language.locale,
                  groupValue: viewModel.language,
                  onChanged: (Locale? newLocale) {
                    if (newLocale != null) {
                      viewModel.updateLanguage(newLocale);
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
