import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../subscription/model/subscription_model.dart';

class SubscriptionBanner extends StatelessWidget {
  const SubscriptionBanner({
    super.key,
    required this.subscriptionStatus,
    required this.onTap,
  });

  final AsyncValue<SubscriptionStatus> subscriptionStatus;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withValues(alpha: .8),
          ],
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
                const Icon(Icons.diamond, color: Colors.white),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Premium',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      subscriptionStatus.maybeWhen(
                        data: (status) => Text(
                          l.current_plan(switch (status.activeType) {
                            SubscriptionType.monthly => l.monthly_subscription,
                            SubscriptionType.yearly => l.yearly_subscription,
                            SubscriptionType.lifetime =>
                              l.lifetime_subscription,
                            SubscriptionType.none => l.free_trial_days(3),
                          }),
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withValues(alpha: .8),
                          ),
                        ),
                        orElse: () => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    if (subscriptionStatus.valueOrNull?.isSubscribed ?? false)
                      Text(
                        l.subscription_expires_in((subscriptionStatus
                                    .valueOrNull?.expirationDate
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
