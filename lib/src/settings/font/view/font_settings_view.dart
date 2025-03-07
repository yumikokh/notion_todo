import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helpers/date.dart';
import '../../../helpers/haptic_helper.dart';
import '../font_constants.dart';
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
    final viewModel = ref.read(fontSettingsViewModelProvider.notifier);

    useEffect(() {
      viewModel.resetTemporarySettings();
      return null;
    }, []);

    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(l.font_settings, style: const TextStyle(fontSize: 16)),
          actions: [
            IconButton(
              onPressed: () async {
                await viewModel.resetTemporarySettings();
                HapticHelper.light();
              },
              icon: const Icon(Icons.refresh),
              tooltip: l.reset,
            ),
            IconButton(
              onPressed: () async {
                await viewModel.saveSettings();
                HapticHelper.selection();
                if (context.mounted) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              },
              icon: const Icon(Icons.check),
              tooltip: l.save,
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
                              onTap: () {
                                Navigator.pop(context, 'en');
                                HapticHelper.light();
                              },
                            ),
                            ListTile(
                              title: Text(l.language_settings_language_ja),
                              onTap: () {
                                Navigator.pop(context, 'ja');
                                HapticHelper.light();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                    if (selectedLanguage != null) {
                      final fonts =
                          FontConstants.getFontsForLocale(selectedLanguage);
                      await viewModel.updateTemporarySettings(
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
                                onTap: () {
                                  Navigator.pop(context, font);
                                  HapticHelper.light();
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
                    if (selectedFont != null) {
                      await viewModel.updateTemporarySettings(
                        settings.copyWith(fontFamily: selectedFont),
                      );
                    }
                  },
                ),
                SwitchListTile(
                  title: _buildSettingTitle(l.italic),
                  value: settings.isItalic,
                  onChanged: (value) async {
                    await viewModel.updateTemporarySettings(
                      settings.copyWith(isItalic: value),
                    );
                    HapticHelper.light();
                  },
                ),
                SwitchListTile(
                  title: _buildSettingTitle(l.bold),
                  value: settings.isBold,
                  onChanged: (value) async {
                    await viewModel.updateTemporarySettings(
                      settings.copyWith(isBold: value),
                    );
                    HapticHelper.light();
                  },
                ),
                ListTile(
                  title: _buildSettingTitle(l.font_size),
                  subtitle: Slider(
                    min: 16,
                    max: 40,
                    value: settings.fontSize,
                    onChanged: (value) async {
                      await viewModel.updateTemporarySettings(
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
                      await viewModel.updateTemporarySettings(
                        settings.copyWith(letterSpacing: value),
                      );
                    },
                  ),
                ),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: FilledButton.icon(
                      onPressed: () async {
                        await viewModel.resetToDefault();
                        HapticHelper.light();
                      },
                      icon: const Icon(Icons.settings_backup_restore),
                      label: Text(l.reset_to_default),
                    ),
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
                      fontStyle: settings.isItalic
                          ? FontStyle.italic
                          : FontStyle.normal,
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
      ),
    );
  }
}
