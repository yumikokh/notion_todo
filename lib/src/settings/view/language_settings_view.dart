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
      (name: 'English', locale: const Locale('en')),
      (name: '日本語', locale: const Locale('ja')),
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
                  groupValue: viewModel.locale,
                  onChanged: (Locale? newLocale) {
                    if (newLocale != null) {
                      viewModel.updateLocale(newLocale);
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
