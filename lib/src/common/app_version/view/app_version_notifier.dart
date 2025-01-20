import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_version_viewmodel.dart';

class AppVersionNotifier {
  static const _releaseNoteUrl =
      'https://yumikokh.notion.site/Release-Note-18154c37a54c807b8ac6ef6612524378';

  static Future<void> checkAndShow(BuildContext context, WidgetRef ref) async {
    final viewModel = ref.read(appVersionViewModelProvider);
    if (!await viewModel.shouldShowUpdateDialog()) return;
    if (!context.mounted) return;

    final l10n = AppLocalizations.of(context)!;
    final version = await viewModel.getCurrentVersion();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.updateMessage(version)),
        action: SnackBarAction(
          label: l10n.releaseNote,
          onPressed: () async {
            if (await canLaunchUrl(Uri.parse(_releaseNoteUrl))) {
              await launchUrl(Uri.parse(_releaseNoteUrl));
            }
          },
        ),
        duration: const Duration(seconds: 5),
        showCloseIcon: true,
      ),
    );
    await viewModel.markUpdateAsSeen();
  }
}
