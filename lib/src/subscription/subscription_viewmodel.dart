import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../common/debounced_state_mixin.dart';
import '../common/snackbar/model/snackbar_state.dart';
import '../common/snackbar/snackbar.dart';
import '../settings/settings_viewmodel.dart';
import 'model/subscription_model.dart';
import 'subscription_repository.dart';
import '../common/analytics/analytics_service.dart';
import '../widget/widget_service.dart';

part 'subscription_viewmodel.g.dart';

@riverpod
class SubscriptionViewModel extends _$SubscriptionViewModel
    with DebouncedStateMixin<SubscriptionStatus> {
  late SubscriptionRepository? _subscriptionRepository;
  bool _isLoading = false;
  List<SubscriptionPlan> _availablePlans = [];

  List<SubscriptionPlan> get availablePlans => _availablePlans;
  bool get isLoading => _isLoading;

  @override
  Future<SubscriptionStatus> build() async {
    _subscriptionRepository =
        await ref.watch(subscriptionRepositoryProvider.future);

    if (_subscriptionRepository == null) {
      final status = SubscriptionStatus(
        isActive: false,
        activeType: SubscriptionType.none,
      );
      WidgetService.updateSubscriptionStatusForWidget(status.isSubscribed);
      return status;
    }

    // 利用可能なプランを取得
    _availablePlans = await _fetchAvailablePlans();

    // 現在のサブスクリプション状態を取得
    final status = await _fetchSubscriptionStatus();
    WidgetService.updateSubscriptionStatusForWidget(status.isSubscribed);
    return status;
  }

  // プレミアム機能が利用可能かどうかをチェック
  bool canAccessPremiumFeature() {
    final status = state.valueOrNull;
    if (status == null) return false;

    return status.isSubscribed;
  }

  // トライアル期間かどうかをチェック
  bool isInTrialPeriod() {
    final status = state.valueOrNull;
    if (status == null) return false;

    return status.isActive && status.isInTrial;
  }

  // 期限切れまでの日数を取得
  int? getDaysUntilExpiration() {
    final status = state.valueOrNull;
    if (status == null || status.expirationDate == null) return null;

    final now = DateTime.now();
    final diff = status.expirationDate!.difference(now);
    return diff.inDays;
  }

  // 購入可能なプランを取得
  Future<List<SubscriptionPlan>> _fetchAvailablePlans() async {
    final subscriptionRepository = _subscriptionRepository;
    if (subscriptionRepository == null) {
      return [];
    }

    return await subscriptionRepository.getAvailablePlans();
  }

  // 現在のサブスクリプション状態を取得
  Future<SubscriptionStatus> _fetchSubscriptionStatus() async {
    final subscriptionRepository = _subscriptionRepository;
    if (subscriptionRepository == null) {
      return SubscriptionStatus(
        isActive: false,
        activeType: SubscriptionType.none,
      );
    }

    return await debouncedFetch(() async {
      final status = await subscriptionRepository.getSubscriptionStatus();
      WidgetService.updateSubscriptionStatusForWidget(status.isSubscribed);
      return status;
    });
  }

  // プランを購入する
  Future<SubscriptionStatus?> purchasePlan(SubscriptionPlan plan) async {
    final subscriptionRepository = _subscriptionRepository;
    if (subscriptionRepository == null) {
      return null;
    }

    final snackbar = ref.read(snackbarProvider.notifier);
    final locale = ref.read(settingsViewModelProvider).locale;
    final l = await AppLocalizations.delegate.load(locale);

    _isLoading = true;
    ref.notifyListeners();

    try {
      final result = await subscriptionRepository.purchasePlan(plan);

      // 購入成功
      state = AsyncValue.data(result);
      snackbar.show(
        l.subscription_purchase_success(plan.name),
        type: SnackbarType.success,
      );

      try {
        final analytics = ref.read(analyticsServiceProvider);
        await analytics.logSubscription(
          'subscription_purchased',
          parameters: {
            'plan_type': plan.type.toString(),
            'plan_id': plan.id,
          },
        );
      } catch (e) {
        print('Analytics error: $e');
      }
      return result;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      if (state.hasValue) {
        WidgetService.updateSubscriptionStatusForWidget(
            state.value!.isSubscribed);
      }
      ref.notifyListeners();
    }
  }

  // 購入を復元する
  Future<SubscriptionStatus?> restorePurchases() async {
    final subscriptionRepository = _subscriptionRepository;
    if (subscriptionRepository == null) {
      return null;
    }

    final snackbar = ref.read(snackbarProvider.notifier);
    final locale = ref.read(settingsViewModelProvider).locale;
    final l = await AppLocalizations.delegate.load(locale);

    _isLoading = true;
    ref.notifyListeners();

    try {
      final result = await subscriptionRepository.restorePurchases();

      if (result != null && result.isActive) {
        // 復元成功
        state = AsyncValue.data(result);
        snackbar.show(
          l.subscription_restore_success,
          type: SnackbarType.success,
        );
        try {
          final analytics = ref.read(analyticsServiceProvider);
          await analytics.logSubscription(
            'subscription_restored',
            parameters: {
              'success': result.isActive,
              'plan_type': result.activeType.toString(),
            },
          );
        } catch (e) {
          print('Analytics error: $e');
        }
      } else {
        // TODO: 位置番手前のモーダルとしてエラー表示&throwしてモーダルを閉じないようにする
        // 復元するものがない
        snackbar.show(
          l.subscription_restore_none,
          type: SnackbarType.info,
        );
      }
      return result;
    } catch (e) {
      // TODO: 位置番手前のモーダルとしてエラー表示&throwしてモーダルを閉じないようにする
      snackbar.show(
        l.subscription_restore_failed,
        type: SnackbarType.error,
      );
      return null;
    } finally {
      _isLoading = false;
      if (state.hasValue) {
        WidgetService.updateSubscriptionStatusForWidget(
            state.value!.isSubscribed);
      }
      ref.notifyListeners();
    }
  }

  Future<void> debugResetSubscription() async {
    final subscriptionRepository = _subscriptionRepository;
    if (subscriptionRepository == null) {
      return;
    }
    await subscriptionRepository.debugResetSubscription();
  }
}
