import 'package:intl/intl.dart';

String formattedCurrency(
  double amount,
  String currencyCode, {
  String? locale = 'ja_JP',
}) {
  final NumberFormat currencyFormatter = NumberFormat.simpleCurrency(
    name: currencyCode,
    locale: locale,
  );
  return currencyFormatter.format(amount);
}
