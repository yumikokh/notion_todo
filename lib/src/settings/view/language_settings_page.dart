import 'package:flutter/material.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../helpers/haptic_helper.dart';
import '../settings_viewmodel.dart';

class LanguageSettingsPage extends ConsumerWidget {
  static const routeName = '/settings/language';

  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final viewModel = ref.read(settingsViewModelProvider.notifier);
    final languages = [
      (name: 'English', locale: const Locale('en')),
      (name: '日本語', locale: const Locale('ja')),
      (name: '한국어', locale: const Locale('ko')),
      (name: '繁體中文', locale: const Locale('zh', 'Hant')),
      (name: 'Español', locale: const Locale('es')),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l.language_settings_title,
            style: const TextStyle(fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListView(
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
                      HapticHelper.light();
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
