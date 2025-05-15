import 'package:flutter/foundation.dart';
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

  static const String _monthlyEntitlementId = 'monthly_pro';
  static const String _yearlyEntitlementId = 'yearly_pro';
  static const String _lifetimeEntitlementId = 'lifetime_pro';

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
        final subscriptionType = _getSubscriptionType(package.identifier);

        plans.add(SubscriptionPlan(
          id: package.identifier,
          name: product.title,
          description: product.description,
          price: product.price,
          type: subscriptionType,
          trialDays: _getTrialDays(package.packageType),
        ));
      }

      return plans;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
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
      Sentry.captureException(e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// 購入を復元します
  Future<SubscriptionStatus> restorePurchases() async {
    try {
      final customerInfo = await Purchases.restorePurchases();
      _cachedStatus = _parseSubscriptionStatus(customerInfo);
      return _cachedStatus!;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return SubscriptionStatus(
        isActive: false,
        activeType: SubscriptionType.none,
      );
    }
  }

  /// CustomerInfoからサブスクリプション状態を解析します
  SubscriptionStatus _parseSubscriptionStatus(CustomerInfo customerInfo) {
    // ライフタイム購入チェック
    final hasLifetime =
        customerInfo.entitlements.active.containsKey(_lifetimeEntitlementId);
    if (hasLifetime) {
      return SubscriptionStatus(
        isActive: true,
        activeType: SubscriptionType.lifetime,
      );
    }

    // 月額サブスクリプションチェック
    final hasMonthly =
        customerInfo.entitlements.active.containsKey(_monthlyEntitlementId);
    if (hasMonthly) {
      final entitlement =
          customerInfo.entitlements.active[_monthlyEntitlementId]!;
      return SubscriptionStatus(
        isActive: true,
        activeType: SubscriptionType.monthly,
        expirationDate: entitlement.expirationDate != null
            ? DateTime.parse(entitlement.expirationDate!)
            : null,
        isInTrial: entitlement.periodType == PeriodType.trial,
      );
    }

    // 年額サブスクリプションチェック
    final hasYearly =
        customerInfo.entitlements.active.containsKey(_yearlyEntitlementId);
    if (hasYearly) {
      final entitlement =
          customerInfo.entitlements.active[_yearlyEntitlementId]!;
      return SubscriptionStatus(
        isActive: true,
        activeType: SubscriptionType.yearly,
        expirationDate: entitlement.expirationDate != null
            ? DateTime.parse(entitlement.expirationDate!)
            : null,
        isInTrial: entitlement.periodType == PeriodType.trial,
      );
    }

    // アクティブなサブスクリプションがない
    return SubscriptionStatus(
      isActive: false,
      activeType: SubscriptionType.none,
    );
  }

  /// パッケージIDからサブスクリプションタイプを取得します
  SubscriptionType _getSubscriptionType(String identifier) {
    if (identifier.contains('monthly')) {
      return SubscriptionType.monthly;
    } else if (identifier.contains('yearly')) {
      return SubscriptionType.yearly;
    } else if (identifier.contains('lifetime')) {
      return SubscriptionType.lifetime;
    }
    return SubscriptionType.none;
  }

  /// パッケージタイプからトライアル期間を取得します
  int _getTrialDays(PackageType packageType) {
    switch (packageType) {
      case PackageType.monthly:
        return 7; // 7日間トライアル
      case PackageType.annual:
        return 30; // 30日間トライアル
      default:
        return 0;
    }
  }
}
