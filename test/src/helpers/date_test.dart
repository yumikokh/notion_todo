import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';
import 'package:tanzaku_todo/src/helpers/date.dart';

void main() {
  late DateHelper dateHelper;

  setUpAll(() async {
    await initializeDateFormatting('ja');
    await initializeDateFormatting('en');
  });

  setUp(() {
    dateHelper = DateHelper();
  });

  group('DateHelper', () {
    group('isThisDay', () {
      test('同じ日付の場合はtrueを返す', () {
        final date1 = DateTime(2024, 1, 1, 10, 30);
        final date2 = DateTime(2024, 1, 1, 15, 45);
        expect(dateHelper.isThisDay(date1, date2), true);
      });

      test('異なる日付の場合はfalseを返す', () {
        final date1 = DateTime(2024, 1, 1);
        final date2 = DateTime(2024, 1, 2);
        expect(dateHelper.isThisDay(date1, date2), false);
      });

      test('nullの場合の処理', () {
        expect(dateHelper.isThisDay(null, null), true);
        expect(dateHelper.isThisDay(DateTime.now(), null), false);
        expect(dateHelper.isThisDay(null, DateTime.now()), false);
      });
    });

    group('formatDateTime', () {
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
      late DateTime now;
      late DateTime today;
      late DateTime yesterday;
      late DateTime tomorrow;
      late DateTime nextMonth;
      late DateTime nextYear;

      setUp(() {
        now = DateTime(2024, 3, 15, 12, 0);
        today = DateTime(now.year, now.month, now.day, 9, 9);
        yesterday = DateTime(now.year, now.month, now.day - 1, 9, 9);
        tomorrow = DateTime(now.year, now.month, now.day + 1, 9, 9);
        nextMonth = DateTime(now.year, now.month + 1, 1, 9, 9);
        nextYear = DateTime(now.year + 1, 1, 1, 9, 9);
        dateHelper.setNow(now);
      });

      testWidgets('今日の日付 - 日本語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          expect(dateHelper.formatDateTime(today, false, context, showToday: true),
              '今日 9:09');
          expect(dateHelper.formatDateTime(today, true, context, showToday: true), '今日');

          expect(
              dateHelper.formatDateTime(today, false, context, showToday: false), '9:09');
          expect(
              dateHelper.formatDateTime(today, false, context,
                  showToday: true, showOnlyTime: true),
              '9:09');
          expect(dateHelper.formatDateTime(today, false, context, showOnlyTime: true),
              '9:09');
        });
      });

      testWidgets('昨日の日付 - 日本語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          expect(dateHelper.formatDateTime(yesterday, false, context), '昨日 9:09');
          expect(dateHelper.formatDateTime(yesterday, true, context), '昨日');
          expect(dateHelper.formatDateTime(yesterday, false, context, showOnlyTime: true),
              '9:09');
        });
      });

      testWidgets('明日の日付 - 日本語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          expect(dateHelper.formatDateTime(tomorrow, false, context), '明日 9:09');
          expect(dateHelper.formatDateTime(tomorrow, true, context), '明日');
          expect(dateHelper.formatDateTime(tomorrow, false, context, showOnlyTime: true),
              '9:09');
        });
      });

      testWidgets('今月の別の日 - 日本語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          final otherDay = DateTime(now.year, now.month, 20, 10, 30);
          expect(dateHelper.formatDateTime(otherDay, false, context), '20 水 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), '20 水');
          expect(dateHelper.formatDateTime(otherDay, false, context, showOnlyTime: true),
              '10:30');
        });
      });

      testWidgets('来月の日付 - 日本語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          expect(dateHelper.formatDateTime(nextMonth, false, context), '4/1 9:09');
          expect(dateHelper.formatDateTime(nextMonth, true, context), '4/1');
          expect(dateHelper.formatDateTime(nextMonth, false, context, showOnlyTime: true),
              '9:09');
        });
      });

      testWidgets('来年の日付 - 日本語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          expect(dateHelper.formatDateTime(nextYear, false, context), '2025/1/1 9:09');
          expect(dateHelper.formatDateTime(nextYear, true, context), '2025/1/1');
          expect(dateHelper.formatDateTime(nextYear, false, context, showOnlyTime: true),
              '9:09');
        });
      });

      testWidgets('今日の日付 - 英語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'en', (context) {
          dateHelper.setup('en');
          expect(dateHelper.formatDateTime(today, false, context, showToday: true),
              'Today 9:09');
          expect(
              dateHelper.formatDateTime(today, true, context, showToday: true), 'Today');
          expect(
              dateHelper.formatDateTime(today, false, context, showToday: false), '9:09');
        });
      });

      testWidgets('昨日の日付 - 英語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'en', (context) {
          dateHelper.setup('en');
          expect(dateHelper.formatDateTime(yesterday, false, context), 'Yesterday 9:09');
          expect(dateHelper.formatDateTime(yesterday, true, context), 'Yesterday');
        });
      });

      testWidgets('明日の日付 - 英語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'en', (context) {
          dateHelper.setup('en');
          expect(dateHelper.formatDateTime(tomorrow, false, context), 'Tomorrow 9:09');
          expect(dateHelper.formatDateTime(tomorrow, true, context), 'Tomorrow');
        });
      });
    });

    group('formatDateForTitle', () {
      test('日本語フォーマット', () {
        final date = DateTime(2024, 1, 1);
        final result = dateHelper.formatDateForTitle(date, locale: 'ja');
        expect(result, '1月1日 (月)');
      });

      test('英語フォーマット', () {
        final date = DateTime(2024, 1, 1);
        final result = dateHelper.formatDateForTitle(date, locale: 'en');
        expect(result, 'Mon, Jan 1');
      });
    });

    group('dateString', () {
      test('ISO形式の日付文字列を返す', () {
        final date = DateTime(2024, 1, 1, 12, 30, 45);
        expect(dateHelper.dateString(date), '2024-01-01');
      });
    });

    group('hasTime', () {
      test('時刻情報が含まれている場合はtrueを返す', () {
        expect(dateHelper.hasTime('2024-01-01T12:30:00'), true);
      });

      test('時刻情報が含まれていない場合はfalseを返す', () {
        expect(dateHelper.hasTime('2024-01-01'), false);
      });
    });

    group('startTimeOfDay and endTimeOfDay', () {
      test('startTimeOfDayは日の開始時刻を返す', () {
        final date = DateTime(2024, 1, 1, 12, 30, 45);
        final result = dateHelper.startTimeOfDay(date);
        expect(result, DateTime(2024, 1, 1, 0, 0, 0));
      });

      test('endTimeOfDayは日の終了時刻を返す', () {
        final date = DateTime(2024, 1, 1, 12, 30, 45);
        final result = dateHelper.endTimeOfDay(date);
        expect(result, DateTime(2024, 1, 1, 23, 59, 59));
      });
    });
  });
}