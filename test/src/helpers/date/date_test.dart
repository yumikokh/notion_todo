import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';
import 'package:tanzaku_todo/src/helpers/date.dart';

void main() {
  late DateHelper dateHelper;

  setUpAll(() async {
    await initializeDateFormatting();
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

    group('isToday', () {
      test('今日の日付の場合はtrueを返す', () {
        final now = DateTime(2024, 3, 15, 12, 0);
        dateHelper.setNow(now);
        final today = DateTime(2024, 3, 15, 9, 30);
        expect(dateHelper.isToday(today), true);
      });

      test('今日でない日付の場合はfalseを返す', () {
        final now = DateTime(2024, 3, 15, 12, 0);
        dateHelper.setNow(now);
        final notToday = DateTime(2024, 3, 16, 9, 30);
        expect(dateHelper.isToday(notToday), false);
      });

      test('nullの場合はfalseを返す', () {
        expect(dateHelper.isToday(null), false);
      });
    });

    group('isSameDay', () {
      test('同じ日付の場合はtrueを返す', () {
        final date1 = DateTime(2024, 1, 1, 10, 30);
        final date2 = DateTime(2024, 1, 1, 15, 45);
        expect(dateHelper.isSameDay(date1, date2), true);
      });

      test('異なる日付の場合はfalseを返す', () {
        final date1 = DateTime(2024, 1, 1);
        final date2 = DateTime(2024, 1, 2);
        expect(dateHelper.isSameDay(date1, date2), false);
      });
    });

    group('formatDate', () {
      test('デフォルトフォーマット', () {
        dateHelper.setup('ja');
        final date = DateTime(2024, 3, 15);
        expect(dateHelper.formatDate(date), '2024-03-15');
      });

      test('カスタムフォーマット', () {
        dateHelper.setup('ja');
        final date = DateTime(2024, 3, 15);
        expect(dateHelper.formatDate(date, format: 'yyyy/MM/dd'), '2024/03/15');
      });
    });

    group('Time-related helpers', () {
      testWidgets('todayString', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('ja'),
            home: Builder(
              builder: (context) {
                expect(dateHelper.todayString(context), '今日');
                return Container();
              },
            ),
          ),
        );
      });

      testWidgets('yesterdayString', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('ja'),
            home: Builder(
              builder: (context) {
                expect(dateHelper.yesterdayString(context), '昨日');
                return Container();
              },
            ),
          ),
        );
      });

      testWidgets('tomorrowString', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('ja'),
            home: Builder(
              builder: (context) {
                expect(dateHelper.tomorrowString(context), '明日');
                return Container();
              },
            ),
          ),
        );
      });
    });
  });
}
