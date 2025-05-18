import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../helpers/haptic_helper.dart';
import '../../helpers/number.dart';
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
    final isSubscribed = currentStatus?.isSubscribed ?? false;

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

                        const SizedBox(height: 24),

                        // プラン一覧
                        _buildPlanOptions(context,
                            plans: plans, selectedPlan: selectedPlan, ref: ref),

                        if (!isSubscribed) ...[
                          const SizedBox(height: 24),
                          // 購入復元ボタン
                          _buildRestoreButton(context, ref),
                        ],
                        // 利用規約とプライバシーポリシー
                        const SizedBox(height: 16),
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
          ],
        );
      },
    );
  }

  Widget _buildFeatureHighlights(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.premium_features_title,
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          l.premium_features_description,
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),

        // 機能リスト
        _buildFeatureItem(context, 'すべてのウィジェットを開放', '複数のウィジェットスタイルから選べます'),
        _buildFeatureItem(context, '今後追加される全機能へのアクセス', '新機能が追加されたらすぐに使えます'),
        _buildFeatureItem(context, 'デベロッパーを応援', '継続的な開発とサポートを支援できます'),
      ],
    );
  }

  Widget _buildFeatureItem(
      BuildContext context, String title, String description) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 24),
          const SizedBox(width: 12),
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
                Text(
                  description,
                  style: theme.textTheme.bodyMedium,
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
      highlightText = l.lifetime_purchase;
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.dividerColor.withAlpha(80),
            width: isSelected ? 3.5 : 2),
      ),
      child: InkWell(
        onTap: onSelect,
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: highlightText.isNotEmpty
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Text(
                switch (plan.type) {
                  SubscriptionType.monthly => l.monthly_subscription,
                  SubscriptionType.yearly => l.yearly_subscription,
                  SubscriptionType.lifetime => l.lifetime_subscription,
                  SubscriptionType.none => 'none'
                },
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (highlightText.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (highlightText.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            margin: const EdgeInsets.only(bottom: 4),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              highlightText,
                              style: TextStyle(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                plan.priceString,
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
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
                                  style: theme.textTheme.bodyMedium?.copyWith(
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
                            ),
                        ],
                      ),
                    ],
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
      onPressed: () {
        HapticHelper.selection();
        ref.read(subscriptionViewModelProvider.notifier).restorePurchases();
      },
      child: Text(l.restore_purchases),
    );
  }

  Widget _buildTermsAndPrivacy(BuildContext context) {
    return const Center(
      child: Text(
        '購入することで、利用規約とプライバシーポリシーに同意したことになります。'
        '\n定期購入はいつでもキャンセルできます。'
        '\nプランを変更する場合は、現在のプラン終了後に自動的に変更されます。',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey,
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
        buttonText = '永久ライセンス取得済み';
        isActive = false;
        break;
      case (SubscriptionType.monthly, SubscriptionType.monthly):
      case (SubscriptionType.yearly, SubscriptionType.yearly):
        buttonText = '購読中';
        isActive = false;
        break;
      case (SubscriptionType.yearly, SubscriptionType.none):
        buttonText = '無料トライアルを開始';
        subText =
            '${selectedPlan?.trialDays}日間の無料体験の終了後は ${selectedPlan?.priceString}/${l.yearly_price}';
        break;
      case (SubscriptionType.monthly, SubscriptionType.none):
      case (SubscriptionType.lifetime, SubscriptionType.none):
        buttonText = '購入を続ける';
        break;
      case (SubscriptionType.monthly, SubscriptionType.yearly):
      case (SubscriptionType.yearly, SubscriptionType.monthly):
      case (SubscriptionType.lifetime, _):
        buttonText = 'プランを変更';
        subText = '現在のプラン: ${switch (subscriptionStatus?.activeType) {
          SubscriptionType.monthly => l.monthly_subscription,
          SubscriptionType.yearly => l.yearly_subscription,
          _ => ''
        }}';
        break;
      case (_, _):
        buttonText = '購入を続ける';
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
                        await ref
                            .read(subscriptionViewModelProvider.notifier)
                            .purchasePlan(selectedPlan);
                        ref.invalidate(subscriptionViewModelProvider);
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      } catch (e) {
                        print('error: $e');
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
                            theme.colorScheme.tertiary,
                            theme.colorScheme.tertiary.withAlpha(210)
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
