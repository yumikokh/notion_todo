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
    if (await viewModel.shouldShowUpdateDialog()) {
      if (context.mounted) {
        final l10n = AppLocalizations.of(context)!;
        final version = await viewModel.getCurrentVersion();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Expanded(
                  child: Text(l10n.updateMessage(version)),
                ),
                TextButton(
                  onPressed: () async {
                    if (await canLaunchUrl(Uri.parse(_releaseNoteUrl))) {
                      await launchUrl(Uri.parse(_releaseNoteUrl));
                    }
                  },
                  child: Text(
                    l10n.releaseNote,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            duration: const Duration(seconds: 8),
          ),
        );
        await viewModel.markUpdateAsSeen();
      }
    }
  }
}
