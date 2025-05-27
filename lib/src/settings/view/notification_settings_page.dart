import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../helpers/haptic_helper.dart';
import '../settings_viewmodel.dart';

class NotificationSettingsPage extends ConsumerWidget {
  const NotificationSettingsPage({super.key});

  static const routeName = '/settings/notification';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final showBadge =
        ref.watch(settingsViewModelProvider).showNotificationBadge;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notifications, style: const TextStyle(fontSize: 18)),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(l10n.showNotificationBadge),
            value: showBadge,
            onChanged: (value) {
              ref
                  .read(settingsViewModelProvider.notifier)
                  .updateShowNotificationBadge(value);
              HapticHelper.light();
            },
          ),
        ],
      ),
    );
  }
}
