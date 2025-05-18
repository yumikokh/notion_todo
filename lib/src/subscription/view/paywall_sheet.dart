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

  /// ボトムシートとして表示する
  static Future<void> show(BuildContext context) {
    HapticHelper.light();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const PaywallSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final subscriptionStatus = ref.watch(subscriptionViewModelProvider);
    final subscriptionViewModel =
        ref.watch(subscriptionViewModelProvider.notifier);
    final isLoading = subscriptionViewModel.isLoading;
    final plans = subscriptionViewModel.availablePlans;

    final monthlyPlan =
        plans.where((p) => p.type == SubscriptionType.monthly).firstOrNull;
    final yearlyPlan =
        plans.where((p) => p.type == SubscriptionType.yearly).firstOrNull;

    final currentStatus = subscriptionStatus.valueOrNull;
    final isSubscribed = currentStatus?.isSubscribed ?? false;

    // 選択されたプランの状態
    final selectedPlan = useState<SubscriptionPlan?>(yearlyPlan);

    return DraggableScrollableSheet(
      initialChildSize: 1.0,
      maxChildSize: 1.0,
      minChildSize: 1.0,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              // コンテンツ
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // debug: キャンセル
                              // if (!isSubscribed)
                              //   ListTile(
                              //     title: const Text('サブスクリプションをリセット'),
                              //     trailing: const Icon(Icons.chevron_right),
                              //     onTap: () {
                              //       subscriptionViewModel
                              //           .debugResetSubscription();
                              //     },
                              //   ),

                              // 有料機能ハイライト
                              _buildFeatureHighlights(context),

                              const SizedBox(height: 24),

                              // プラン一覧
                              _buildPlanOptions(context,
                                  plans: plans,
                                  selectedPlan: selectedPlan,
                                  ref: ref),

                              if (!isSubscribed) ...[
                                const SizedBox(height: 24),

                                // 購入復元ボタン
                                _buildRestoreButton(context, ref),

                                // 利用規約とプライバシーポリシー
                                const SizedBox(height: 16),
                                _buildTermsAndPrivacy(context),
                              ],
                            ],
                          ),
                        ),
                      ),
              ),
              // 下部固定エリア
              if (!isSubscribed)
                _buildBottomPinnedArea(
                    context, ref, selectedPlan.value, monthlyPlan, yearlyPlan),
            ],
          ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
      onPressed: () => _restorePurchases(context, ref),
      child: Text(l.restore_purchases),
    );
  }

  Widget _buildTermsAndPrivacy(BuildContext context) {
    return const Center(
      child: Text(
        '購入することで、利用規約とプライバシーポリシーに同意したことになります。'
        '\n定期購入はいつでもキャンセルできます。',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    );
  }

  Future<void> _subscribeToPlan(
      BuildContext context, WidgetRef ref, SubscriptionPlan plan) async {
    HapticHelper.selection();

    try {
      await ref.read(subscriptionViewModelProvider.notifier).purchasePlan(plan);
      // 成功時はスナックバーで表示（すでにViewModelで表示されている）
    } catch (e) {
      // エラー時の処理（すでにViewModelで表示されている）
    }
  }

  Future<void> _restorePurchases(BuildContext context, WidgetRef ref) async {
    HapticHelper.selection();

    try {
      await ref.read(subscriptionViewModelProvider.notifier).restorePurchases();
      // 成功時はスナックバーで表示（すでにViewModelで表示されている）
    } catch (e) {
      // エラー時の処理（すでにViewModelで表示されている）
    }
  }

  // 下部固定エリアのウィジェット (プレースホルダー)
  Widget _buildBottomPinnedArea(
    BuildContext context,
    WidgetRef ref,
    SubscriptionPlan? selectedPlan,
    SubscriptionPlan? monthlyPlan, // 価格情報などのために必要かも
    SubscriptionPlan? yearlyPlan, // 価格情報などのために必要かも
  ) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    if (selectedPlan == null) {
      // プランが選択されていない場合は何も表示しないか、デフォルトのメッセージ
      return const SizedBox.shrink();
    }

    String buttonText = '';
    String subText = ''; // 年額プラン用の小さい文字

    switch (selectedPlan.type) {
      case SubscriptionType.monthly:
        buttonText = 'つづける';
        break;
      case SubscriptionType.yearly:
        buttonText = '無料トライアルを開始';
        subText =
            '${selectedPlan.trialDays}日間の無料体験の終了後は ${selectedPlan.priceString}/年';
        break;
      case SubscriptionType.lifetime:
        buttonText = 'つづける';
        break;
      case SubscriptionType.none:
        throw UnimplementedError();
    }

    return Container(
      padding: const EdgeInsets.all(16).copyWith(
          bottom: MediaQuery.of(context).padding.bottom + 16), // SafeArea対応
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -5), // 上方向に影
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
              onPressed: () {
                _subscribeToPlan(context, ref, selectedPlan);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(buttonText),
                  if (subText.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      subText,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal),
                    ),
                  ]
                ],
              )),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
