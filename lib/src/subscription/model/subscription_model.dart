enum SubscriptionType {
  monthly,
  yearly,
  lifetime,
  none,
}

class SubscriptionPlan {
  final String id;
  final String name;
  final String description;
  final double price;
  final String priceString;
  final String currencyCode;
  final SubscriptionType type;
  final int trialDays;

  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.priceString,
    required this.currencyCode,
    required this.type,
    this.trialDays = 0,
  });
}

class SubscriptionStatus {
  final bool isActive;
  final SubscriptionType activeType;
  final DateTime? expirationDate;
  final bool isInTrial;
  final bool hasActiveSubscription;

  SubscriptionStatus({
    required this.isActive,
    required this.activeType,
    this.expirationDate,
    this.isInTrial = false,
    this.hasActiveSubscription = false,
  });

  bool get isExpired =>
      expirationDate != null && DateTime.now().isAfter(expirationDate!);
  bool get isSubscribed => isActive && !isExpired;
  bool get hasLifetime => activeType == SubscriptionType.lifetime && isActive;
}
