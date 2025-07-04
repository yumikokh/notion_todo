import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../settings/theme/theme.dart';
import '../../../subscription/model/subscription_model.dart';

class SubscriptionBanner extends StatelessWidget {
  const SubscriptionBanner({
    super.key,
    required this.subscriptionStatus,
    required this.onTap,
  });

  final SubscriptionStatus subscriptionStatus;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.warmBeige.color,
            Theme.of(context)
                .colorScheme
                .warmBeige
                .color
                .withValues(alpha: 0.8),
            Theme.of(context).colorScheme.warmBeige.color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.diamond,
                    color: Color.fromARGB(211, 255, 255, 255)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.premium_features_title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l.current_plan(switch (subscriptionStatus.activeType) {
                          SubscriptionType.monthly => l.monthly_subscription,
                          SubscriptionType.yearly => l.yearly_subscription,
                          SubscriptionType.lifetime => l.lifetime_purchase,
                          SubscriptionType.none => l.free_trial_days(7),
                        }),
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withValues(alpha: .8),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    if (subscriptionStatus.isInTrial)
                      Text(
                        l.trial_subscription_expires_in((subscriptionStatus
                                    .expirationDate
                                    ?.difference(DateTime.now())
                                    .inDays ??
                                0) +
                            1),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
