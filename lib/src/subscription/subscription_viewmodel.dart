import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../common/debounced_state_mixin.dart';
import '../common/error.dart';
import '../common/snackbar/model/snackbar_state.dart';
import '../common/snackbar/snackbar.dart';
import '../settings/settings_viewmodel.dart';
import 'model/subscription_model.dart';
import 'subscription_repository.dart';
import '../common/analytics/analytics_service.dart';

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
      return SubscriptionStatus(
        isActive: false,
        activeType: SubscriptionType.none,
      );
    }

    // 利用可能なプランを取得
    _availablePlans = await _fetchAvailablePlans();

    // 現在のサブスクリプション状態を取得
    return await _fetchSubscriptionStatus();
  }

  // 購入可能なプランを取得
  Future<List<SubscriptionPlan>> _fetchAvailablePlans() async {
    final subscriptionService = _subscriptionRepository;
    if (subscriptionService == null) {
      return [];
    }

    try {
      return await subscriptionService.getAvailablePlans();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return [];
    }
  }

  // 現在のサブスクリプション状態を取得
  Future<SubscriptionStatus> _fetchSubscriptionStatus() async {
    final subscriptionService = _subscriptionRepository;
    if (subscriptionService == null) {
      return SubscriptionStatus(
        isActive: false,
        activeType: SubscriptionType.none,
      );
    }

    return await debouncedFetch(() async {
      try {
        return await subscriptionService.getSubscriptionStatus();
      } catch (e, stackTrace) {
        final snackbar = ref.read(snackbarProvider.notifier);
        final analytics = ref.read(analyticsServiceProvider);
        final locale = ref.read(settingsViewModelProvider).locale;
        final l = await AppLocalizations.delegate.load(locale);

        Sentry.captureException(e, stackTrace: stackTrace);

        if (e is NotionErrorException) {
          snackbar.show(l.subscription_fetch_failed, type: SnackbarType.error);
          await analytics.logError(
            e.code,
            error: e.message,
            parameters: {'status_code': e.status},
          );
        } else {
          snackbar.show(l.subscription_fetch_failed, type: SnackbarType.error);
          print('Unknown error: $e');
        }

        return SubscriptionStatus(
          isActive: false,
          activeType: SubscriptionType.none,
        );
      }
    });
  }

  // プランを購入する
  Future<void> purchasePlan(SubscriptionPlan plan) async {
    final subscriptionService = _subscriptionRepository;
    if (subscriptionService == null) {
      return;
    }

    final snackbar = ref.read(snackbarProvider.notifier);
    final locale = ref.read(settingsViewModelProvider).locale;
    final l = await AppLocalizations.delegate.load(locale);

    _isLoading = true;
    ref.notifyListeners();

    try {
      final result = await subscriptionService.purchasePlan(plan);

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
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      snackbar.show(
        l.subscription_purchase_failed,
        type: SnackbarType.error,
      );
    } finally {
      _isLoading = false;
      ref.notifyListeners();
    }
  }

  // 購入を復元する
  Future<void> restorePurchases() async {
    final subscriptionService = _subscriptionRepository;
    if (subscriptionService == null) {
      return;
    }

    final snackbar = ref.read(snackbarProvider.notifier);
    final locale = ref.read(settingsViewModelProvider).locale;
    final l = await AppLocalizations.delegate.load(locale);

    _isLoading = true;
    ref.notifyListeners();

    try {
      final result = await subscriptionService.restorePurchases();

      if (result.isActive) {
        // 復元成功
        state = AsyncValue.data(result);
        snackbar.show(
          l.subscription_restore_success,
          type: SnackbarType.success,
        );
      } else {
        // 復元するものがない
        snackbar.show(
          l.subscription_restore_none,
          type: SnackbarType.info,
        );
      }

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
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      snackbar.show(
        l.subscription_restore_failed,
        type: SnackbarType.error,
      );
    } finally {
      _isLoading = false;
      ref.notifyListeners();
    }
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
}
