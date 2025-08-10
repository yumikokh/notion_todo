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
          expect(
              dateHelper.formatDateTime(today, false, context, showToday: true),
              '今日 9:09');
          expect(
              dateHelper.formatDateTime(today, true, context, showToday: true),
              '今日');

          expect(
              dateHelper.formatDateTime(today, false, context,
                  showToday: false),
              '9:09');
          expect(
              dateHelper.formatDateTime(today, false, context,
                  showToday: true, showOnlyTime: true),
              '9:09');
          expect(
              dateHelper.formatDateTime(today, false, context,
                  showOnlyTime: true),
              '9:09');
        });
      });

      testWidgets('昨日の日付 - 日本語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          expect(
              dateHelper.formatDateTime(yesterday, false, context), '昨日 9:09');
          expect(dateHelper.formatDateTime(yesterday, true, context), '昨日');
          expect(
              dateHelper.formatDateTime(yesterday, false, context,
                  showOnlyTime: true),
              '9:09');
        });
      });

      testWidgets('明日の日付 - 日本語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          expect(
              dateHelper.formatDateTime(tomorrow, false, context), '明日 9:09');
          expect(dateHelper.formatDateTime(tomorrow, true, context), '明日');
          expect(
              dateHelper.formatDateTime(tomorrow, false, context,
                  showOnlyTime: true),
              '9:09');
        });
      });

      testWidgets('1週間以内の未来の日付 - 日本語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          // 3日後の日付
          final threeDaysLater = now.add(const Duration(days: 3));
          final otherDay = DateTime(threeDaysLater.year, threeDaysLater.month,
              threeDaysLater.day, 10, 30);
          expect(
              dateHelper.formatDateTime(otherDay, false, context), '月 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), '月');
          expect(
              dateHelper.formatDateTime(otherDay, false, context,
                  showOnlyTime: true),
              '10:30');
        });
      });

      testWidgets('過去の日付（同じ月） - 日本語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          final threeDaysAgo = now.add(const Duration(days: -3));
          final otherDay = DateTime(
              threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 10, 30);
          expect(dateHelper.formatDateTime(otherDay, false, context),
              '3月12日 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), '3月12日');
          expect(
              dateHelper.formatDateTime(otherDay, false, context,
                  showOnlyTime: true),
              '10:30');
        });
      });

      testWidgets('1週間を超える日付 - 日本語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          // 10日後の日付（1週間を超える）
          final tenDaysLater = now.add(const Duration(days: 10));
          final futureDay = DateTime(
              tenDaysLater.year, tenDaysLater.month, tenDaysLater.day, 10, 30);
          final result = dateHelper.formatDateTime(futureDay, true, context);
          // 月日形式で表示されることを確認
          expect(result, contains('月'));
          expect(result, contains('日'));
        });
      });

      testWidgets('来月の日付 - 日本語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          expect(dateHelper.formatDateTime(nextMonth, false, context),
              '4月1日 9:09');
          expect(dateHelper.formatDateTime(nextMonth, true, context), '4月1日');
          expect(
              dateHelper.formatDateTime(nextMonth, false, context,
                  showOnlyTime: true),
              '9:09');
        });
      });

      testWidgets('来年の日付 - 日本語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          expect(dateHelper.formatDateTime(nextYear, false, context),
              '2025年1月1日 9:09');
          expect(
              dateHelper.formatDateTime(nextYear, true, context), '2025年1月1日');
          expect(
              dateHelper.formatDateTime(nextYear, false, context,
                  showOnlyTime: true),
              '9:09');
        });
      });

      testWidgets('今日の日付 - 英語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'en', (context) {
          dateHelper.setup('en');
          expect(
              dateHelper.formatDateTime(today, false, context, showToday: true),
              'Today 9:09');
          expect(
              dateHelper.formatDateTime(today, true, context, showToday: true),
              'Today');
          expect(
              dateHelper.formatDateTime(today, false, context,
                  showToday: false),
              '9:09');
        });
      });

      testWidgets('昨日の日付 - 英語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'en', (context) {
          dateHelper.setup('en');
          expect(dateHelper.formatDateTime(yesterday, false, context),
              'Yesterday 9:09');
          expect(
              dateHelper.formatDateTime(yesterday, true, context), 'Yesterday');
        });
      });

      testWidgets('明日の日付 - 英語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'en', (context) {
          dateHelper.setup('en');
          expect(dateHelper.formatDateTime(tomorrow, false, context),
              'Tomorrow 9:09');
          expect(
              dateHelper.formatDateTime(tomorrow, true, context), 'Tomorrow');
        });
      });

      testWidgets('1週間以内の未来の日付 - 英語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'en', (context) {
          dateHelper.setup('en');
          final threeDaysLater = now.add(const Duration(days: 3));
          final otherDay = DateTime(threeDaysLater.year, threeDaysLater.month,
              threeDaysLater.day, 10, 30);
          expect(
              dateHelper.formatDateTime(otherDay, false, context), 'Mon 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), 'Mon');
          expect(
              dateHelper.formatDateTime(otherDay, false, context,
                  showOnlyTime: true),
              '10:30');
        });
      });

      testWidgets('過去の日付（同じ月） - 英語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'en', (context) {
          dateHelper.setup('en');
          final threeDaysAgo = now.add(const Duration(days: -3));
          final otherDay = DateTime(
              threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 10, 30);
          expect(dateHelper.formatDateTime(otherDay, false, context),
              'Mar 12 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), 'Mar 12');
          expect(
              dateHelper.formatDateTime(otherDay, false, context,
                  showOnlyTime: true),
              '10:30');
        });
      });

      testWidgets('1週間を超える日付 - 英語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'en', (context) {
          dateHelper.setup('en');
          final tenDaysLater = now.add(const Duration(days: 10));
          final futureDay = DateTime(
              tenDaysLater.year, tenDaysLater.month, tenDaysLater.day, 10, 30);
          final result = dateHelper.formatDateTime(futureDay, true, context);
          expect(result, matches(RegExp(r'[A-Za-z]+ \d+')));
        });
      });
      testWidgets('今日の日付 - 韓国語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ko', (context) {
          dateHelper.setup('ko');
          expect(
              dateHelper.formatDateTime(today, false, context, showToday: true),
              '오늘 9:09');
          expect(
              dateHelper.formatDateTime(today, true, context, showToday: true),
              '오늘');
          expect(
              dateHelper.formatDateTime(today, false, context,
                  showToday: false),
              '9:09');
        });
      });

      testWidgets('昨日の日付 - 韓国語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ko', (context) {
          dateHelper.setup('ko');
          expect(dateHelper.formatDateTime(yesterday, false, context),
              '어제 9:09');
          expect(
              dateHelper.formatDateTime(yesterday, true, context), '어제');
        });
      });

      testWidgets('明日の日付 - 韓国語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ko', (context) {
          dateHelper.setup('ko');
          expect(dateHelper.formatDateTime(tomorrow, false, context),
              '내일 9:09');
          expect(
              dateHelper.formatDateTime(tomorrow, true, context), '내일');
        });
      });

      testWidgets('1週間以内の未来の日付 - 韓国語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ko', (context) {
          dateHelper.setup('ko');
          final threeDaysLater = now.add(const Duration(days: 3));
          final otherDay = DateTime(threeDaysLater.year, threeDaysLater.month,
              threeDaysLater.day, 10, 30);
          expect(
              dateHelper.formatDateTime(otherDay, false, context), '월 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), '월');
        });
      });

      testWidgets('過去の日付（同じ月） - 韓国語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ko', (context) {
          dateHelper.setup('ko');
          final threeDaysAgo = now.add(const Duration(days: -3));
          final otherDay = DateTime(
              threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 10, 30);
          expect(dateHelper.formatDateTime(otherDay, false, context),
              '3월 12일 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), '3월 12일');
        });
      });

      testWidgets('今日の日付 - 中国語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'zh', (context) {
          dateHelper.setup('zh');
          expect(
              dateHelper.formatDateTime(today, false, context, showToday: true),
              '今天 9:09');
          expect(
              dateHelper.formatDateTime(today, true, context, showToday: true),
              '今天');
          expect(
              dateHelper.formatDateTime(today, false, context,
                  showToday: false),
              '9:09');
        });
      });

      testWidgets('昨日の日付 - 中国語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'zh', (context) {
          dateHelper.setup('zh');
          expect(dateHelper.formatDateTime(yesterday, false, context),
              '昨天 9:09');
          expect(
              dateHelper.formatDateTime(yesterday, true, context), '昨天');
        });
      });

      testWidgets('明日の日付 - 中国語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'zh', (context) {
          dateHelper.setup('zh');
          expect(dateHelper.formatDateTime(tomorrow, false, context),
              '明天 9:09');
          expect(
              dateHelper.formatDateTime(tomorrow, true, context), '明天');
        });
      });

      testWidgets('1週間以内の未来の日付 - 中国語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'zh', (context) {
          dateHelper.setup('zh');
          final threeDaysLater = now.add(const Duration(days: 3));
          final otherDay = DateTime(threeDaysLater.year, threeDaysLater.month,
              threeDaysLater.day, 10, 30);
          expect(
              dateHelper.formatDateTime(otherDay, false, context), '周一 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), '周一');
        });
      });

      testWidgets('過去の日付（同じ月） - 中国語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'zh', (context) {
          dateHelper.setup('zh');
          final threeDaysAgo = now.add(const Duration(days: -3));
          final otherDay = DateTime(
              threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 10, 30);
          expect(dateHelper.formatDateTime(otherDay, false, context),
              '3月12日 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), '3月12日');
        });
      });

      testWidgets('今日の日付 - スペイン語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'es', (context) {
          dateHelper.setup('es');
          expect(
              dateHelper.formatDateTime(today, false, context, showToday: true),
              'Hoy 9:09');
          expect(
              dateHelper.formatDateTime(today, true, context, showToday: true),
              'Hoy');
          expect(
              dateHelper.formatDateTime(today, false, context,
                  showToday: false),
              '9:09');
        });
      });

      testWidgets('昨日の日付 - スペイン語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'es', (context) {
          dateHelper.setup('es');
          expect(dateHelper.formatDateTime(yesterday, false, context),
              'Ayer 9:09');
          expect(
              dateHelper.formatDateTime(yesterday, true, context), 'Ayer');
        });
      });

      testWidgets('明日の日付 - スペイン語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'es', (context) {
          dateHelper.setup('es');
          expect(dateHelper.formatDateTime(tomorrow, false, context),
              'Mañana 9:09');
          expect(
              dateHelper.formatDateTime(tomorrow, true, context), 'Mañana');
        });
      });

      testWidgets('1週間以内の未来の日付 - スペイン語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'es', (context) {
          dateHelper.setup('es');
          final threeDaysLater = now.add(const Duration(days: 3));
          final otherDay = DateTime(threeDaysLater.year, threeDaysLater.month,
              threeDaysLater.day, 10, 30);
          expect(
              dateHelper.formatDateTime(otherDay, false, context), 'lun 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), 'lun');
        });
      });

      testWidgets('過去の日付（同じ月） - スペイン語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'es', (context) {
          dateHelper.setup('es');
          final threeDaysAgo = now.add(const Duration(days: -3));
          final otherDay = DateTime(
              threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 10, 30);
          expect(dateHelper.formatDateTime(otherDay, false, context),
              '12 mar 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), '12 mar');
        });
      });

      testWidgets('今日の日付 - フランス語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'fr', (context) {
          dateHelper.setup('fr');
          expect(
              dateHelper.formatDateTime(today, false, context, showToday: true),
              'Aujourd9ui');
          expect(
              dateHelper.formatDateTime(today, true, context, showToday: true),
              'Aujourd9ui');
          expect(
              dateHelper.formatDateTime(today, false, context,
                  showToday: false),
              '9:09');
        });
      });

      testWidgets('昨日の日付 - フランス語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'fr', (context) {
          dateHelper.setup('fr');
          expect(dateHelper.formatDateTime(yesterday, false, context),
              'Hier 9:09');
          expect(
              dateHelper.formatDateTime(yesterday, true, context), 'Hier');
        });
      });

      testWidgets('明日の日付 - フランス語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'fr', (context) {
          dateHelper.setup('fr');
          expect(dateHelper.formatDateTime(tomorrow, false, context),
              'Demain 9:09');
          expect(
              dateHelper.formatDateTime(tomorrow, true, context), 'Demain');
        });
      });

      testWidgets('1週間以内の未来の日付 - フランス語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'fr', (context) {
          dateHelper.setup('fr');
          final threeDaysLater = now.add(const Duration(days: 3));
          final otherDay = DateTime(threeDaysLater.year, threeDaysLater.month,
              threeDaysLater.day, 10, 30);
          expect(
              dateHelper.formatDateTime(otherDay, false, context), 'lun. 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), 'lun.');
        });
      });

      testWidgets('過去の日付（同じ月） - フランス語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'fr', (context) {
          dateHelper.setup('fr');
          final threeDaysAgo = now.add(const Duration(days: -3));
          final otherDay = DateTime(
              threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 10, 30);
          expect(dateHelper.formatDateTime(otherDay, false, context),
              '12 mars 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), '12 mars');
        });
      });

      testWidgets('今日の日付 - ドイツ語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'de', (context) {
          dateHelper.setup('de');
          expect(
              dateHelper.formatDateTime(today, false, context, showToday: true),
              'Heute 9:09');
          expect(
              dateHelper.formatDateTime(today, true, context, showToday: true),
              'Heute');
          expect(
              dateHelper.formatDateTime(today, false, context,
                  showToday: false),
              '9:09');
        });
      });

      testWidgets('昨日の日付 - ドイツ語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'de', (context) {
          dateHelper.setup('de');
          expect(dateHelper.formatDateTime(yesterday, false, context),
              'Gestern 9:09');
          expect(
              dateHelper.formatDateTime(yesterday, true, context), 'Gestern');
        });
      });

      testWidgets('明日の日付 - ドイツ語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'de', (context) {
          dateHelper.setup('de');
          expect(dateHelper.formatDateTime(tomorrow, false, context),
              'Morgen 9:09');
          expect(
              dateHelper.formatDateTime(tomorrow, true, context), 'Morgen');
        });
      });

      testWidgets('1週間以内の未来の日付 - ドイツ語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'de', (context) {
          dateHelper.setup('de');
          final threeDaysLater = now.add(const Duration(days: 3));
          final otherDay = DateTime(threeDaysLater.year, threeDaysLater.month,
              threeDaysLater.day, 10, 30);
          expect(
              dateHelper.formatDateTime(otherDay, false, context), 'Mo. 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), 'Mo');
        });
      });

      testWidgets('過去の日付（同じ月） - ドイツ語', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'de', (context) {
          dateHelper.setup('de');
          final threeDaysAgo = now.add(const Duration(days: -3));
          final otherDay = DateTime(
              threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 10, 30);
          expect(dateHelper.formatDateTime(otherDay, false, context),
              '12. März 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), '12. März');
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

      test('韓国語フォーマット', () {
        dateHelper.setup('ko');
        final result = dateHelper.formatDateForTitle(DateTime(2024, 3, 15));
        expect(result, contains('3월 15일'));
        expect(result, contains('('));
        expect(result, contains('금요일'));
      });

      test('中国語フォーマット', () {
        dateHelper.setup('zh');
        final result = dateHelper.formatDateForTitle(DateTime(2024, 3, 15));
        expect(result, contains('3月15日'));
        expect(result, contains('星期五'));
      });

      test('スペイン語フォーマット', () {
        dateHelper.setup('es');
        final result = dateHelper.formatDateForTitle(DateTime(2024, 3, 15));
        expect(result,
            matches(RegExp(r'Viernes, 15 de marzo', caseSensitive: false)));
      });

      test('フランス語フォーマット', () {
        dateHelper.setup('fr');
        final result = dateHelper.formatDateForTitle(DateTime(2024, 3, 15));
        expect(
            result, matches(RegExp(r'Vendredi 15 mars', caseSensitive: false)));
      });

      test('ドイツ語フォーマット', () {
        dateHelper.setup('de');
        final result = dateHelper.formatDateForTitle(DateTime(2024, 3, 15));
        expect(result,
            matches(RegExp(r'Freitag, 15. März', caseSensitive: false)));
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
