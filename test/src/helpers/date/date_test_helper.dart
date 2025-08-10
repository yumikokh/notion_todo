import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';

/// 共通のテストヘルパー関数
Future<void> testFormatDateTime(
  WidgetTester tester,
  String locale,
  void Function(BuildContext context) testFunction,
) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(locale),
      home: Builder(
        builder: (BuildContext context) {
          testFunction(context);
          return Container();
        },
      ),
    ),
  );
}

/// テスト用の日付を生成するクラス
class TestDates {
  final DateTime now;
  late final DateTime today;
  late final DateTime yesterday;
  late final DateTime tomorrow;
  late final DateTime nextMonth;
  late final DateTime nextYear;

  TestDates({DateTime? baseDate}) : now = baseDate ?? DateTime(2024, 3, 15, 12, 0) {
    today = DateTime(now.year, now.month, now.day, 9, 9);
    yesterday = DateTime(now.year, now.month, now.day - 1, 9, 9);
    tomorrow = DateTime(now.year, now.month, now.day + 1, 9, 9);
    nextMonth = DateTime(now.year, now.month + 1, 1, 9, 9);
    nextYear = DateTime(now.year + 1, 1, 1, 9, 9);
  }
}