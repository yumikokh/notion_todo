import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
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

      test('今日の日付 - 日本語', () {
        dateHelper.setup('ja');
        expect(dateHelper.formatDateTime(today, false, showToday: true),
            '今日 9:09');
        expect(dateHelper.formatDateTime(today, true, showToday: true), '今日');

        expect(
            dateHelper.formatDateTime(today, false, showToday: false), '9:09');
        expect(
            dateHelper.formatDateTime(today, false,
                showToday: true, showOnlyTime: true),
            '9:09');
        expect(dateHelper.formatDateTime(today, false, showOnlyTime: true),
            '9:09');
      });

      test('昨日の日付 - 日本語', () {
        dateHelper.setup('ja');
        expect(dateHelper.formatDateTime(yesterday, false), '昨日 9:09');
        expect(dateHelper.formatDateTime(yesterday, true), '昨日');
        expect(dateHelper.formatDateTime(yesterday, false, showOnlyTime: true),
            '9:09');
      });

      test('明日の日付 - 日本語', () {
        dateHelper.setup('ja');
        expect(dateHelper.formatDateTime(tomorrow, false), '明日 9:09');
        expect(dateHelper.formatDateTime(tomorrow, true), '明日');
        expect(dateHelper.formatDateTime(tomorrow, false, showOnlyTime: true),
            '9:09');
      });

      test('今月の別の日 - 日本語', () {
        dateHelper.setup('ja');
        final otherDay = DateTime(now.year, now.month, 20, 10, 30);
        expect(dateHelper.formatDateTime(otherDay, false), '20 水 10:30');
        expect(dateHelper.formatDateTime(otherDay, true), '20 水');
        expect(dateHelper.formatDateTime(otherDay, false, showOnlyTime: true),
            '10:30');
      });

      test('来月の日付 - 日本語', () {
        dateHelper.setup('ja');
        expect(dateHelper.formatDateTime(nextMonth, false), '4/1 9:09');
        expect(dateHelper.formatDateTime(nextMonth, true), '4/1');
        expect(dateHelper.formatDateTime(nextMonth, false, showOnlyTime: true),
            '9:09');
      });

      test('来年の日付 - 日本語', () {
        dateHelper.setup('ja');
        expect(dateHelper.formatDateTime(nextYear, false), '2025/1/1 9:09');
        expect(dateHelper.formatDateTime(nextYear, true), '2025/1/1');
        expect(dateHelper.formatDateTime(nextYear, false, showOnlyTime: true),
            '9:09');
      });

      test('今日の日付 - 英語', () {
        dateHelper.setup('en');
        expect(dateHelper.formatDateTime(today, false, showToday: true),
            'Today 9:09');
        expect(
            dateHelper.formatDateTime(today, true, showToday: true), 'Today');
        expect(
            dateHelper.formatDateTime(today, false, showToday: false), '9:09');
      });

      test('昨日の日付 - 英語', () {
        dateHelper.setup('en');
        expect(dateHelper.formatDateTime(yesterday, false), 'Yesterday 9:09');
        expect(dateHelper.formatDateTime(yesterday, true), 'Yesterday');
      });

      test('明日の日付 - 英語', () {
        dateHelper.setup('en');
        expect(dateHelper.formatDateTime(tomorrow, false), 'Tomorrow 9:09');
        expect(dateHelper.formatDateTime(tomorrow, true), 'Tomorrow');
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
  });
}
