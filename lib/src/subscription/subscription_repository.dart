import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../env/env.dart';
import 'model/subscription_model.dart';

part 'subscription_repository.g.dart';

@riverpod
Future<SubscriptionRepository> subscriptionRepository(Ref ref) async {
  final repository =
      SubscriptionRepository(revenueCatApiKey: Env.revenueCatApiKey);
  await repository.initialize();
  return repository;
}

class SubscriptionRepository {
  final String revenueCatApiKey;

  SubscriptionRepository({required this.revenueCatApiKey});

  static const String _entitlementId = 'Premium';
  static const String _monthlyEntitlementId =
      'com.ymkokh.notionTodo.premium.monthly';
  static const String _yearlyEntitlementId =
      'com.ymkokh.notionTodo.premium.yearly';
  static const String _lifetimeEntitlementId = 'com.ymkokh.notionTodo.Lifetime';

  SubscriptionStatus? _cachedStatus;

  /// RevenueCatの初期化を行います
  Future<void> initialize() async {
    if (kDebugMode) {
      await Purchases.setLogLevel(LogLevel.debug);
    }

    // APIキーの設定（iOS/Androidで異なる場合は分岐する）
    await Purchases.configure(PurchasesConfiguration(revenueCatApiKey));
  }

  /// 利用可能なプランを取得します
  Future<List<SubscriptionPlan>> getAvailablePlans() async {
    try {
      final offerings = await Purchases.getOfferings();
      final offering = offerings.current;

      if (offering == null) {
        return [];
      }

      final plans = <SubscriptionPlan>[];

      for (final package in offering.availablePackages) {
        final product = package.storeProduct;
        final subscriptionType = _getSubscriptionType(product.identifier);

        plans.add(SubscriptionPlan(
          id: package.identifier,
          name: product.title,
          description: product.description,
          price: product.price,
          priceString: product.priceString,
          currencyCode: product.currencyCode,
          type: subscriptionType,
          trialDays: switch (subscriptionType) {
            SubscriptionType.yearly => 7,
            _ => 0,
          },
        ));
      }

      return plans;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      print('getAvailablePlans error: $e');
      return [];
    }
  }

  /// 現在のサブスクリプション状態を取得します
  Future<SubscriptionStatus> getSubscriptionStatus() async {
    if (_cachedStatus != null) {
      return _cachedStatus!;
    }

    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return _parseSubscriptionStatus(customerInfo);
    } catch (e, stackTrace) {
      print('getSubscriptionStatus error: $e');
      Sentry.captureException(e, stackTrace: stackTrace);
      return SubscriptionStatus(
        isActive: false,
        activeType: SubscriptionType.none,
      );
    }
  }

  /// プランを購入します
  Future<SubscriptionStatus> purchasePlan(SubscriptionPlan plan) async {
    try {
      final offerings = await Purchases.getOfferings();
      final offering = offerings.current;

      if (offering == null) {
        throw Exception('No offerings available');
      }

      final package = offering.availablePackages.firstWhere(
        (p) => p.identifier == plan.id,
        orElse: () => throw Exception('Package not found: ${plan.id}'),
      );

      final result = await Purchases.purchasePackage(package);
      _cachedStatus = _parseSubscriptionStatus(result);
      return _cachedStatus!;
    } catch (e, stackTrace) {
      if (e is PlatformException &&
          (e.code == '1' ||
              e.details?['userCancelled'] == true ||
              e.details?['readableErrorCode'] == 'PURCHASE_CANCELLED')) {
        print('ユーザーが購入をキャンセルしました');
        rethrow;
      }
      print('purchasePlan error: $e');

      // APIエラーの検出のためSentryに記録
      Sentry.captureException(e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// 購入を復元します
  Future<SubscriptionStatus?> restorePurchases() async {
    try {
      final customerInfo = await Purchases.restorePurchases();
      _cachedStatus = _parseSubscriptionStatus(customerInfo);

      return _cachedStatus;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// デバッグ専用：サブスクリプションをリセットします
  /// このメソッドはデバッグビルドでのみ使用してください
  Future<SubscriptionStatus> debugResetSubscription() async {
    print('debugResetSubscription: $kDebugMode');
    if (!kDebugMode) {
      throw UnsupportedError('This method can only be used in debug mode');
    }

    try {
      // await Purchases.logOut();
      // RevenueCat SDKのキャッシュを無効化
      await Purchases.invalidateCustomerInfoCache();
      // アプリ内キャッシュをクリア
      _cachedStatus = null;
      return await getSubscriptionStatus();
    } catch (e) {
      print('debugResetSubscription error: $e');
      return SubscriptionStatus(
        isActive: false,
        activeType: SubscriptionType.none,
      );
    }
  }

  /// CustomerInfoからサブスクリプション状態を解析します
  SubscriptionStatus _parseSubscriptionStatus(CustomerInfo customerInfo) {
    final entitlement = customerInfo.entitlements.all[_entitlementId];
    if (entitlement == null || !entitlement.isActive) {
      return SubscriptionStatus(
        isActive: false,
        activeType: SubscriptionType.none,
      );
    }

    final subscriptionType = switch (entitlement.productIdentifier) {
      _monthlyEntitlementId => SubscriptionType.monthly,
      _yearlyEntitlementId => SubscriptionType.yearly,
      _lifetimeEntitlementId => SubscriptionType.lifetime,
      _ => throw Exception('Invalid entitlement product identifier'),
    };

    return SubscriptionStatus(
      isActive: true,
      activeType: subscriptionType,
      expirationDate: entitlement.expirationDate != null
          ? DateTime.parse(entitlement.expirationDate!)
          : null,
      isInTrial: entitlement.periodType == PeriodType.trial,
      hasActiveSubscription: customerInfo.activeSubscriptions.isNotEmpty,
    );
  }

  /// パッケージIDからサブスクリプションタイプを取得します
  SubscriptionType _getSubscriptionType(String identifier) {
    if (identifier == _monthlyEntitlementId) {
      return SubscriptionType.monthly;
    } else if (identifier == _yearlyEntitlementId) {
      return SubscriptionType.yearly;
    } else if (identifier == _lifetimeEntitlementId) {
      return SubscriptionType.lifetime;
    }
    return SubscriptionType.none;
  }
}
