import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/error.dart';
import '../../helpers/haptic_helper.dart';
import '../../helpers/number.dart';
import '../../settings/theme/theme.dart';
import '../model/subscription_model.dart';
import '../subscription_viewmodel.dart';

class PaywallSheet extends HookConsumerWidget {
  const PaywallSheet({super.key});

  static Future<void> show(BuildContext context) {
    HapticHelper.light();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const PaywallSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionStatus = ref.watch(subscriptionViewModelProvider);
    final subscriptionViewModel =
        ref.watch(subscriptionViewModelProvider.notifier);
    final isLoading = subscriptionViewModel.isLoading;
    final plans = subscriptionViewModel.availablePlans;
    final currentStatus = subscriptionStatus.valueOrNull;

    // 年額プランをデフォルトで選択
    final selectedPlan = useState<SubscriptionPlan?>(plans
        .where((p) =>
            p.type ==
            (currentStatus?.activeType != SubscriptionType.none
                ? currentStatus?.activeType
                : SubscriptionType.yearly))
        .firstOrNull);

    return BottomSheet(
      onClosing: () {},
      enableDrag: true,
      builder: (context) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                children: [
                  // コンテンツ
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(
                          top: 56, left: 16, right: 16, bottom: 16),
                      children: [
                        // 有料機能ハイライト
                        _buildFeatureHighlights(context),

                        const SizedBox(height: 40),

                        // プラン一覧
                        _buildPlanOptions(context,
                            plans: plans, selectedPlan: selectedPlan, ref: ref),

                        const SizedBox(height: 24),
                        // 購入復元ボタン
                        _buildRestoreButton(context, ref),

                        // 利用規約とプライバシーポリシー
                        const SizedBox(height: 20),
                        _buildTermsAndPrivacy(context),
                      ],
                    ),
                  ),
                  _buildBottomPinnedArea(context, ref, selectedPlan.value,
                      currentStatus, isLoading),
                ],
              ),
            ),
            Positioned(
              top: 20,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.close, size: 32),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.black.withAlpha(128),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildFeatureHighlights(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),

        // 機能リスト
        _buildFeatureItem(context, Icons.widgets, l.unlock_all_widgets_title,
            l.unlock_all_widgets_description),
        _buildFeatureItem(
            context,
            Icons.star,
            l.access_all_future_features_title,
            l.access_all_future_features_description),
        _buildFeatureItem(context, Icons.favorite,
            l.support_the_developer_title, l.support_the_developer_description),
      ],
    );
  }

  Widget _buildFeatureItem(
      BuildContext context, IconData icon, String title, String description) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                Theme.of(context).colorScheme.warmBeige.color,
                Theme.of(context)
                    .colorScheme
                    .warmBeige
                    .color
                    .withValues(alpha: 0.6),
                Theme.of(context).colorScheme.warmBeige.colorContainer
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanOptions(
    BuildContext context, {
    required List<SubscriptionPlan> plans,
    required ValueNotifier<SubscriptionPlan?>
        selectedPlan, // ValueNotifier を受け取る
    required WidgetRef ref,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: plans
          .map((plan) => _buildPlanCard(
                context,
                plan: plan,
                isSelected: selectedPlan.value == plan,
                onSelect: () {
                  HapticHelper.selection();
                  selectedPlan.value = plan;
                },
              ))
          .toList(),
    );
  }

  Widget _buildPlanCard(
    BuildContext context, {
    required SubscriptionPlan plan,
    required bool isSelected,
    required VoidCallback onSelect,
  }) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    String savingsText = '';
    String highlightText = '';

    if (plan.type == SubscriptionType.yearly) {
      savingsText =
          '${formattedCurrency(plan.price / 12, plan.currencyCode, locale: Localizations.localeOf(context).languageCode)} / ${l.monthly_price}';
      highlightText = l.free_trial_days(plan.trialDays);
    } else if (plan.type == SubscriptionType.lifetime) {
      savingsText = l.lifetime_unlock_description;
      highlightText = l.lifetime_purchase;
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
            color: isSelected
                ? theme.colorScheme.warmBeige.color
                : theme.dividerColor.withAlpha(80),
            width: isSelected ? 3.5 : 2),
      ),
      child: InkWell(
        onTap: onSelect,
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: highlightText.isNotEmpty
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      switch (plan.type) {
                        SubscriptionType.monthly => l.monthly_subscription,
                        SubscriptionType.yearly => l.yearly_subscription,
                        SubscriptionType.lifetime => l.lifetime_subscription,
                        SubscriptionType.none => ''
                      },
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (highlightText.isNotEmpty) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  theme.colorScheme.warmBeige.color,
                                  theme.colorScheme.warmBeige.color
                                      .withValues(alpha: 0.6),
                                  theme.colorScheme.warmBeige.color
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: const [0.0, 0.83, 1.0],
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              highlightText,
                              style: TextStyle(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          plan.priceString,
                                          style: theme.textTheme.titleLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          switch (plan.type) {
                                            SubscriptionType.monthly =>
                                              '/ ${l.monthly_price}',
                                            SubscriptionType.yearly =>
                                              '/ ${l.yearly_price}',
                                            _ => ''
                                          },
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (savingsText.isNotEmpty)
                                    Text(
                                      savingsText,
                                      style: TextStyle(
                                        color: theme.colorScheme.secondary,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestoreButton(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;

    return TextButton(
        onPressed: () async {
          HapticHelper.selection();
          try {
            await ref
                .read(subscriptionViewModelProvider.notifier)
                .restorePurchases();

            if (context.mounted) {
              Navigator.of(context).pop();
            }
          } catch (e) {
            if (!context.mounted) return;
            if (e is PurchaseNoActiveSubscriptionException) {
              await showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  content: Text(l.subscription_restore_none),
                  contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                  actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                  actions: [
                    TextButton(
                      child: Text(l.ok),
                      onPressed: () => Navigator.of(dialogContext).pop(),
                    ),
                  ],
                ),
              );
            } else {
              await showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  content: Text(l.subscription_restore_failed),
                  contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                  actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                  actions: [
                    TextButton(
                      child: Text(l.ok),
                      onPressed: () => Navigator.of(dialogContext).pop(),
                    ),
                  ],
                ),
              );
            }
          }
        },
        child: Text(l.restore_purchases));
  }

  Widget _buildTermsAndPrivacy(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    const String termsUrl =
        'https://yumikokh.notion.site/Terms-Conditions-14b54c37a54c808690add6c26c737f7c';
    const String privacyUrl =
        'https://yumikokh.notion.site/Privacy-Policy-14b54c37a54c80e1b288c0097bb6c7bd';

    Future<void> launchUrlHelper(String url) async {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }

    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
          ),
          children: <TextSpan>[
            TextSpan(
              text: l.terms_of_service,
              style: TextStyle(
                color: theme.colorScheme.primary,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  HapticHelper.selection();
                  launchUrlHelper(termsUrl);
                },
            ),
            const TextSpan(text: '・'),
            TextSpan(
              text: l.privacy_policy,
              style: TextStyle(
                color: theme.colorScheme.primary,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  HapticHelper.selection();
                  launchUrlHelper(privacyUrl);
                },
            ),
            const TextSpan(text: '\n\n'),
            TextSpan(text: l.purchase_terms_and_conditions_part3),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPinnedArea(
    BuildContext context,
    WidgetRef ref,
    SubscriptionPlan? selectedPlan,
    SubscriptionStatus? subscriptionStatus,
    bool isLoading,
  ) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    String buttonText = '';
    String subText = '';
    bool isActive = true;

    switch ((selectedPlan?.type, subscriptionStatus?.activeType)) {
      case (_, SubscriptionType.lifetime):
        buttonText = l.lifetime_license_activated;
        isActive = false;
        // isActive = true; // debug
        break;
      case (SubscriptionType.monthly, SubscriptionType.monthly):
      case (SubscriptionType.yearly, SubscriptionType.yearly):
        buttonText = l.currently_subscribed;
        isActive = false;
        break;
      case (SubscriptionType.yearly, SubscriptionType.none):
        buttonText = l.start_free_trial;
        if (selectedPlan != null) {
          subText = l.trial_ends_then_price_per_year(
            selectedPlan.trialDays.toString(),
            selectedPlan.priceString,
            l.yearly_price_short,
          );
        }
        break;
      case (SubscriptionType.monthly, SubscriptionType.none):
      case (SubscriptionType.lifetime, SubscriptionType.none):
        buttonText = l.continue_purchase;
        break;
      case (SubscriptionType.monthly, SubscriptionType.yearly):
      case (SubscriptionType.yearly, SubscriptionType.monthly):
      case (SubscriptionType.lifetime, _):
        buttonText = l.change_plan;
        subText =
            l.current_plan_display(switch (subscriptionStatus?.activeType) {
          SubscriptionType.monthly => l.monthly_subscription,
          SubscriptionType.yearly => l.yearly_subscription,
          _ => ''
        });
        break;
      case (_, _):
        buttonText = l.continue_purchase;
    }

    return Container(
      padding: const EdgeInsets.all(16)
          .copyWith(bottom: MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
              onPressed: isActive && !isLoading
                  ? () async {
                      if (selectedPlan == null) return;
                      HapticHelper.selection();
                      try {
                        final status = await ref
                            .read(subscriptionViewModelProvider.notifier)
                            .purchasePlan(selectedPlan);

                        if (status.hasLifetime &&
                            status.hasActiveSubscription &&
                            context.mounted) {
                          await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (dialogContext) => AlertDialog(
                              title:
                                  Text(l.subscription_purchase_success_title),
                              content: Text(l.switchToLifetimeNotificationBody),
                              actions: [
                                TextButton(
                                  child: Text(l.ok),
                                  onPressed: () =>
                                      Navigator.of(dialogContext).pop(),
                                ),
                              ],
                              titlePadding:
                                  const EdgeInsets.fromLTRB(24, 24, 24, 12),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(24, 12, 24, 20),
                              actionsPadding:
                                  const EdgeInsets.fromLTRB(24, 0, 24, 16),
                            ),
                          );
                        }

                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      } catch (e) {
                        if (e is PurchaseCancelledException) {
                          return;
                        }
                        if (e is PurchaseAlreadyHasLifetimeSubscriptionException &&
                            context.mounted) {
                          await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (dialogContext) => AlertDialog(
                              content:
                                  Text(l.subscription_purchase_success_body),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(24, 24, 24, 20),
                              actionsPadding:
                                  const EdgeInsets.fromLTRB(24, 0, 24, 16),
                              actions: [
                                TextButton(
                                  child: Text(l.ok),
                                  onPressed: () =>
                                      Navigator.of(dialogContext).pop(),
                                ),
                              ],
                            ),
                          );
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        } else if (context.mounted) {
                          await showDialog(
                            context: context,
                            builder: (dialogContext) => AlertDialog(
                              content: Text(l.subscription_purchase_failed),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(24, 24, 24, 20),
                              actionsPadding:
                                  const EdgeInsets.fromLTRB(24, 0, 24, 16),
                              actions: [
                                TextButton(
                                  child: Text(l.ok),
                                  onPressed: () =>
                                      Navigator.of(dialogContext).pop(),
                                ),
                              ],
                            ),
                          );
                        }
                        print('PaywallSheet purchase error: $e');
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                animationDuration: const Duration(milliseconds: 10),
                elevation: isActive ? 5 : 0,
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: isActive && !isLoading
                      ? LinearGradient(
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.primary.withValues(alpha: 0.9),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isActive ? null : Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        buttonText,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isActive
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.onSurface.withAlpha(128),
                        ),
                      ),
                      if (subText.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          subText,
                          style: TextStyle(
                            fontSize: 12,
                            color: isActive
                                ? theme.colorScheme.onPrimary.withAlpha(200)
                                : theme.colorScheme.onSurface.withAlpha(128),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              )),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
