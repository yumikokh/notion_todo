import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helpers/date.dart';
import '../font_settings.dart';
import '../font_settings_viewmodel.dart';

class FontSettingsView extends HookConsumerWidget {
  const FontSettingsView({super.key});

  static final DateHelper d = DateHelper();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontSettings = ref.watch(fontSettingsViewModelProvider);
    final l = AppLocalizations.of(context)!;
    final today = d.formatDateForTitle(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(l.font_settings, style: const TextStyle(fontSize: 20)),
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
          return ListView(
            children: [
              ListTile(
                title: Text(l.font_family),
                subtitle: Text(settings.fontFamily),
                onTap: () async {
                  final fonts = GoogleFonts.asMap().keys.toList();
                  final selectedFont = await showDialog<String>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(l.select_font),
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
                                style: GoogleFonts.getFont(font),
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
                title: Text(l.italic),
                value: settings.isItalic,
                onChanged: (value) async {
                  await ref
                      .read(fontSettingsViewModelProvider.notifier)
                      .updateFontSettings(
                        settings.copyWith(isItalic: value),
                      );
                },
              ),
              ListTile(
                title: Text(l.font_size),
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
                title: Text(l.letter_spacing),
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
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 20),
                child: Text(
                  today,
                  style: GoogleFonts.getFont(
                    settings.fontFamily,
                    fontSize: settings.fontSize,
                    fontStyle:
                        settings.isItalic ? FontStyle.italic : FontStyle.normal,
                    letterSpacing: settings.letterSpacing,
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
