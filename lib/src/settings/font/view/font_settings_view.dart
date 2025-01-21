import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helpers/date.dart';
import '../font_constants.dart';
import '../font_settings.dart';
import '../font_settings_viewmodel.dart';

class FontSettingsView extends HookConsumerWidget {
  const FontSettingsView({super.key});

  static final DateHelper d = DateHelper();

  Widget _buildSettingTitle(String text) {
    return Text(text, style: const TextStyle(fontSize: 14));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontSettings = ref.watch(fontSettingsViewModelProvider);
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.font_settings, style: const TextStyle(fontSize: 18)),
        actions: [
          IconButton(
            onPressed: () async {
              await ref
                  .read(fontSettingsViewModelProvider.notifier)
                  .updateFontSettings(const FontSettings());
            },
            icon: const Icon(Icons.refresh),
            tooltip: l.reset,
          ),
        ],
      ),
      body: fontSettings.when(
        data: (settings) {
          final today = d.formatDateForTitle(
            DateTime.now(),
            locale: settings.languageCode,
          );
          return ListView(
            children: [
              ListTile(
                title: _buildSettingTitle(l.font_language),
                trailing: Text(
                  settings.languageCode == 'en'
                      ? l.language_settings_language_en
                      : l.language_settings_language_ja,
                  style: const TextStyle(fontSize: 14),
                ),
                onTap: () async {
                  final selectedLanguage = await showDialog<String>(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(l.language_settings_language_en),
                            onTap: () => Navigator.pop(context, 'en'),
                          ),
                          ListTile(
                            title: Text(l.language_settings_language_ja),
                            onTap: () => Navigator.pop(context, 'ja'),
                          ),
                        ],
                      ),
                    ),
                  );
                  if (selectedLanguage != null) {
                    final fonts =
                        FontConstants.getFontsForLocale(selectedLanguage);
                    await ref
                        .read(fontSettingsViewModelProvider.notifier)
                        .updateFontSettings(
                          settings.copyWith(
                            languageCode: selectedLanguage,
                            fontFamily: fonts.first,
                          ),
                        );
                  }
                },
              ),
              ListTile(
                title: SizedBox(
                  width: double.maxFinite,
                  height: 24,
                  child: _buildSettingTitle(l.font_family),
                ),
                trailing: Text(settings.fontFamily,
                    style: const TextStyle(fontSize: 14)),
                onTap: () async {
                  final fonts =
                      FontConstants.getFontsForLocale(settings.languageCode);
                  final selectedFont = await showDialog<String>(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: SizedBox(
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: fonts.length,
                          itemBuilder: (context, index) {
                            final font = fonts[index];
                            return ListTile(
                              title: Text(
                                font,
                                style: FontConstants.getFont(font),
                              ),
                              onTap: () => Navigator.pop(context, font),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                  if (selectedFont != null) {
                    await ref
                        .read(fontSettingsViewModelProvider.notifier)
                        .updateFontSettings(
                          settings.copyWith(fontFamily: selectedFont),
                        );
                  }
                },
              ),
              SwitchListTile(
                title: _buildSettingTitle(l.italic),
                value: settings.isItalic,
                onChanged: (value) async {
                  await ref
                      .read(fontSettingsViewModelProvider.notifier)
                      .updateFontSettings(
                        settings.copyWith(isItalic: value),
                      );
                },
              ),
              SwitchListTile(
                title: _buildSettingTitle(l.bold),
                value: settings.isBold,
                onChanged: (value) async {
                  await ref
                      .read(fontSettingsViewModelProvider.notifier)
                      .updateFontSettings(
                        settings.copyWith(isBold: value),
                      );
                },
              ),
              ListTile(
                title: _buildSettingTitle(l.font_size),
                subtitle: Slider(
                  min: 16,
                  max: 40,
                  value: settings.fontSize,
                  onChanged: (value) async {
                    await ref
                        .read(fontSettingsViewModelProvider.notifier)
                        .updateFontSettings(
                          settings.copyWith(fontSize: value),
                        );
                  },
                ),
              ),
              ListTile(
                title: _buildSettingTitle(l.letter_spacing),
                subtitle: Slider(
                  min: -2,
                  max: 2,
                  value: settings.letterSpacing,
                  onChanged: (value) async {
                    await ref
                        .read(fontSettingsViewModelProvider.notifier)
                        .updateFontSettings(
                          settings.copyWith(letterSpacing: value),
                        );
                  },
                ),
              ),
              const SizedBox(height: 12),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Text(
                  today,
                  style: FontConstants.getFont(settings.fontFamily).copyWith(
                    fontSize: settings.fontSize,
                    fontStyle:
                        settings.isItalic ? FontStyle.italic : FontStyle.normal,
                    letterSpacing: settings.letterSpacing,
                    fontWeight: settings.isBold ? FontWeight.bold : null,
                  ),
                ),
              ),
            ],
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stack) => Center(child: Text(error.toString())),
      ),
    );
  }
}
