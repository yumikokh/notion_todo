import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_version_viewmodel.dart';

class AppVersionDialog extends ConsumerWidget {
  const AppVersionDialog({super.key});

  static Future<void> checkAndShow(BuildContext context, WidgetRef ref) async {
    final viewModel = ref.read(appVersionViewModelProvider);
    if (await viewModel.shouldShowUpdateDialog()) {
      if (context.mounted) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const AppVersionDialog(),
        );
        await viewModel.markUpdateAsSeen();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.updateTitle),
      content: Text(l10n.updateMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.ok),
        ),
      ],
    );
  }
}
