import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tanzaku_todo/src/helpers/date.dart';
import 'date_test_helper.dart';

void main() {
  late DateHelper dateHelper;
  late TestDates testDates;

  setUpAll(() async {
    await initializeDateFormatting();
  });

  setUp(() {
    dateHelper = DateHelper();
    testDates = TestDates();
    dateHelper.setNow(testDates.now);
  });

  group('DateHelper - formatDateTime', () {
    group('日本語', () {
      testWidgets('今日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          expect(
              dateHelper.formatDateTime(testDates.today, false, context, showToday: true),
              '今日 9:09');
          expect(
              dateHelper.formatDateTime(testDates.today, true, context, showToday: true),
              '今日');

          expect(
              dateHelper.formatDateTime(testDates.today, false, context,
                  showToday: false),
              '9:09');
          expect(
              dateHelper.formatDateTime(testDates.today, false, context,
                  showToday: true, showOnlyTime: true),
              '9:09');
          expect(
              dateHelper.formatDateTime(testDates.today, false, context,
                  showOnlyTime: true),
              '9:09');
        });
      });

      testWidgets('昨日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          expect(
              dateHelper.formatDateTime(testDates.yesterday, false, context), '昨日 9:09');
          expect(dateHelper.formatDateTime(testDates.yesterday, true, context), '昨日');
          expect(
              dateHelper.formatDateTime(testDates.yesterday, false, context,
                  showOnlyTime: true),
              '9:09');
        });
      });

      testWidgets('明日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          expect(
              dateHelper.formatDateTime(testDates.tomorrow, false, context), '明日 9:09');
          expect(dateHelper.formatDateTime(testDates.tomorrow, true, context), '明日');
          expect(
              dateHelper.formatDateTime(testDates.tomorrow, false, context,
                  showOnlyTime: true),
              '9:09');
        });
      });

      testWidgets('1週間以内の未来の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          // 3日後の日付
          final threeDaysLater = testDates.now.add(const Duration(days: 3));
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

      testWidgets('過去の日付（同じ月）', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          final threeDaysAgo = testDates.now.add(const Duration(days: -3));
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

      testWidgets('1週間を超える日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          // 10日後の日付（1週間を超える）
          final tenDaysLater = testDates.now.add(const Duration(days: 10));
          final futureDay = DateTime(
              tenDaysLater.year, tenDaysLater.month, tenDaysLater.day, 10, 30);
          expect(dateHelper.formatDateTime(futureDay, false, context),
              '3月25日 10:30');
          expect(dateHelper.formatDateTime(futureDay, true, context), '3月25日');
        });
      });

      testWidgets('来月の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          expect(dateHelper.formatDateTime(testDates.nextMonth, false, context),
              '4月1日 9:09');
          expect(dateHelper.formatDateTime(testDates.nextMonth, true, context), '4月1日');
          expect(
              dateHelper.formatDateTime(testDates.nextMonth, false, context,
                  showOnlyTime: true),
              '9:09');
        });
      });

      testWidgets('来年の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ja', (context) {
          dateHelper.setup('ja');
          expect(dateHelper.formatDateTime(testDates.nextYear, false, context),
              '2025年1月1日 9:09');
          expect(
              dateHelper.formatDateTime(testDates.nextYear, true, context), '2025年1月1日');
          expect(
              dateHelper.formatDateTime(testDates.nextYear, false, context,
                  showOnlyTime: true),
              '9:09');
        });
      });
    });

    group('英語', () {
      testWidgets('今日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'en', (context) {
          dateHelper.setup('en');
          expect(
              dateHelper.formatDateTime(testDates.today, false, context, showToday: true),
              'Today 9:09');
          expect(
              dateHelper.formatDateTime(testDates.today, true, context, showToday: true),
              'Today');
          expect(
              dateHelper.formatDateTime(testDates.today, false, context,
                  showToday: false),
              '9:09');
        });
      });

      testWidgets('昨日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'en', (context) {
          dateHelper.setup('en');
          expect(dateHelper.formatDateTime(testDates.yesterday, false, context),
              'Yesterday 9:09');
          expect(
              dateHelper.formatDateTime(testDates.yesterday, true, context), 'Yesterday');
        });
      });

      testWidgets('明日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'en', (context) {
          dateHelper.setup('en');
          expect(dateHelper.formatDateTime(testDates.tomorrow, false, context),
              'Tomorrow 9:09');
          expect(
              dateHelper.formatDateTime(testDates.tomorrow, true, context), 'Tomorrow');
        });
      });

      testWidgets('1週間以内の未来の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'en', (context) {
          dateHelper.setup('en');
          final threeDaysLater = testDates.now.add(const Duration(days: 3));
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

      testWidgets('過去の日付（同じ月）', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'en', (context) {
          dateHelper.setup('en');
          final threeDaysAgo = testDates.now.add(const Duration(days: -3));
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

      testWidgets('1週間を超える日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'en', (context) {
          dateHelper.setup('en');
          final tenDaysLater = testDates.now.add(const Duration(days: 10));
          final futureDay = DateTime(
              tenDaysLater.year, tenDaysLater.month, tenDaysLater.day, 10, 30);
          expect(dateHelper.formatDateTime(futureDay, false, context),
              'Mar 25 10:30');
          expect(dateHelper.formatDateTime(futureDay, true, context), 'Mar 25');
        });
      });

      testWidgets('来月の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'en', (context) {
          dateHelper.setup('en');
          expect(dateHelper.formatDateTime(testDates.nextMonth, false, context),
              'Apr 1 9:09');
          expect(dateHelper.formatDateTime(testDates.nextMonth, true, context), 'Apr 1');
        });
      });

      testWidgets('来年の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'en', (context) {
          dateHelper.setup('en');
          expect(dateHelper.formatDateTime(testDates.nextYear, false, context),
              'Jan 1, 2025 9:09');
          expect(dateHelper.formatDateTime(testDates.nextYear, true, context), 'Jan 1, 2025');
        });
      });
    });

    group('韓国語', () {
      testWidgets('今日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ko', (context) {
          dateHelper.setup('ko');
          expect(
              dateHelper.formatDateTime(testDates.today, false, context, showToday: true),
              '오늘 9:09');
          expect(
              dateHelper.formatDateTime(testDates.today, true, context, showToday: true),
              '오늘');
          expect(
              dateHelper.formatDateTime(testDates.today, false, context,
                  showToday: false),
              '9:09');
        });
      });

      testWidgets('昨日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ko', (context) {
          dateHelper.setup('ko');
          expect(
              dateHelper.formatDateTime(testDates.yesterday, false, context), '어제 9:09');
          expect(dateHelper.formatDateTime(testDates.yesterday, true, context), '어제');
        });
      });

      testWidgets('明日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ko', (context) {
          dateHelper.setup('ko');
          expect(
              dateHelper.formatDateTime(testDates.tomorrow, false, context), '내일 9:09');
          expect(dateHelper.formatDateTime(testDates.tomorrow, true, context), '내일');
        });
      });

      testWidgets('1週間以内の未来の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ko', (context) {
          dateHelper.setup('ko');
          final threeDaysLater = testDates.now.add(const Duration(days: 3));
          final otherDay = DateTime(threeDaysLater.year, threeDaysLater.month,
              threeDaysLater.day, 10, 30);
          expect(
              dateHelper.formatDateTime(otherDay, false, context), '월 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), '월');
        });
      });

      testWidgets('過去の日付（同じ月）', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ko', (context) {
          dateHelper.setup('ko');
          final threeDaysAgo = testDates.now.add(const Duration(days: -3));
          final otherDay = DateTime(
              threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 10, 30);
          expect(dateHelper.formatDateTime(otherDay, false, context),
              '3월12일 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), '3월12일');
        });
      });

      testWidgets('1週間を超える日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ko', (context) {
          dateHelper.setup('ko');
          final tenDaysLater = testDates.now.add(const Duration(days: 10));
          final futureDay = DateTime(
              tenDaysLater.year, tenDaysLater.month, tenDaysLater.day, 10, 30);
          expect(dateHelper.formatDateTime(futureDay, false, context),
              '3월25일 10:30');
          expect(dateHelper.formatDateTime(futureDay, true, context), '3월25일');
        });
      });

      testWidgets('来月の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ko', (context) {
          dateHelper.setup('ko');
          expect(dateHelper.formatDateTime(testDates.nextMonth, false, context),
              '4월1일 9:09');
          expect(dateHelper.formatDateTime(testDates.nextMonth, true, context), '4월1일');
        });
      });

      testWidgets('来年の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'ko', (context) {
          dateHelper.setup('ko');
          expect(dateHelper.formatDateTime(testDates.nextYear, false, context),
              '2025년1월1일 9:09');
          expect(dateHelper.formatDateTime(testDates.nextYear, true, context), '2025년1월1일');
        });
      });
    });

    group('中国語', () {
      testWidgets('今日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'zh', (context) {
          dateHelper.setup('zh');
          expect(
              dateHelper.formatDateTime(testDates.today, false, context, showToday: true),
              '今天 9:09');
          expect(
              dateHelper.formatDateTime(testDates.today, true, context, showToday: true),
              '今天');
          expect(
              dateHelper.formatDateTime(testDates.today, false, context,
                  showToday: false),
              '9:09');
        });
      });

      testWidgets('昨日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'zh', (context) {
          dateHelper.setup('zh');
          expect(
              dateHelper.formatDateTime(testDates.yesterday, false, context), '昨天 9:09');
          expect(dateHelper.formatDateTime(testDates.yesterday, true, context), '昨天');
        });
      });

      testWidgets('明日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'zh', (context) {
          dateHelper.setup('zh');
          expect(
              dateHelper.formatDateTime(testDates.tomorrow, false, context), '明天 9:09');
          expect(dateHelper.formatDateTime(testDates.tomorrow, true, context), '明天');
        });
      });

      testWidgets('1週間以内の未来の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'zh', (context) {
          dateHelper.setup('zh');
          final threeDaysLater = testDates.now.add(const Duration(days: 3));
          final otherDay = DateTime(threeDaysLater.year, threeDaysLater.month,
              threeDaysLater.day, 10, 30);
          expect(
              dateHelper.formatDateTime(otherDay, false, context), '周一 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), '周一');
        });
      });

      testWidgets('過去の日付（同じ月）', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'zh', (context) {
          dateHelper.setup('zh');
          final threeDaysAgo = testDates.now.add(const Duration(days: -3));
          final otherDay = DateTime(
              threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 10, 30);
          expect(dateHelper.formatDateTime(otherDay, false, context),
              '3月12日 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), '3月12日');
        });
      });

      testWidgets('1週間を超える日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'zh', (context) {
          dateHelper.setup('zh');
          final tenDaysLater = testDates.now.add(const Duration(days: 10));
          final futureDay = DateTime(
              tenDaysLater.year, tenDaysLater.month, tenDaysLater.day, 10, 30);
          expect(dateHelper.formatDateTime(futureDay, false, context),
              '3月25日 10:30');
          expect(dateHelper.formatDateTime(futureDay, true, context), '3月25日');
        });
      });

      testWidgets('来月の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'zh', (context) {
          dateHelper.setup('zh');
          expect(dateHelper.formatDateTime(testDates.nextMonth, false, context),
              '4月1日 9:09');
          expect(dateHelper.formatDateTime(testDates.nextMonth, true, context), '4月1日');
        });
      });

      testWidgets('来年の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'zh', (context) {
          dateHelper.setup('zh');
          expect(dateHelper.formatDateTime(testDates.nextYear, false, context),
              '2025年1月1日 9:09');
          expect(dateHelper.formatDateTime(testDates.nextYear, true, context), '2025年1月1日');
        });
      });
    });

    group('スペイン語', () {
      testWidgets('今日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'es', (context) {
          dateHelper.setup('es');
          expect(
              dateHelper.formatDateTime(testDates.today, false, context, showToday: true),
              'Hoy 9:09');
          expect(
              dateHelper.formatDateTime(testDates.today, true, context, showToday: true),
              'Hoy');
          expect(
              dateHelper.formatDateTime(testDates.today, false, context,
                  showToday: false),
              '9:09');
        });
      });

      testWidgets('昨日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'es', (context) {
          dateHelper.setup('es');
          expect(dateHelper.formatDateTime(testDates.yesterday, false, context),
              'Ayer 9:09');
          expect(dateHelper.formatDateTime(testDates.yesterday, true, context), 'Ayer');
        });
      });

      testWidgets('明日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'es', (context) {
          dateHelper.setup('es');
          expect(dateHelper.formatDateTime(testDates.tomorrow, false, context),
              'Mañana 9:09');
          expect(dateHelper.formatDateTime(testDates.tomorrow, true, context), 'Mañana');
        });
      });

      testWidgets('1週間以内の未来の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'es', (context) {
          dateHelper.setup('es');
          final threeDaysLater = testDates.now.add(const Duration(days: 3));
          final otherDay = DateTime(threeDaysLater.year, threeDaysLater.month,
              threeDaysLater.day, 10, 30);
          expect(
              dateHelper.formatDateTime(otherDay, false, context), 'lun 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), 'lun');
        });
      });

      testWidgets('過去の日付（同じ月）', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'es', (context) {
          dateHelper.setup('es');
          final threeDaysAgo = testDates.now.add(const Duration(days: -3));
          final otherDay = DateTime(
              threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 10, 30);
          expect(dateHelper.formatDateTime(otherDay, false, context),
              '12 mar 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), '12 mar');
        });
      });

      testWidgets('1週間を超える日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'es', (context) {
          dateHelper.setup('es');
          final tenDaysLater = testDates.now.add(const Duration(days: 10));
          final futureDay = DateTime(
              tenDaysLater.year, tenDaysLater.month, tenDaysLater.day, 10, 30);
          expect(dateHelper.formatDateTime(futureDay, false, context),
              '25 mar 10:30');
          expect(dateHelper.formatDateTime(futureDay, true, context), '25 mar');
        });
      });

      testWidgets('来月の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'es', (context) {
          dateHelper.setup('es');
          expect(dateHelper.formatDateTime(testDates.nextMonth, false, context),
              '1 abr 9:09');
          expect(dateHelper.formatDateTime(testDates.nextMonth, true, context), '1 abr');
        });
      });

      testWidgets('来年の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'es', (context) {
          dateHelper.setup('es');
          expect(dateHelper.formatDateTime(testDates.nextYear, false, context),
              '1 ene 2025 9:09');
          expect(dateHelper.formatDateTime(testDates.nextYear, true, context), '1 ene 2025');
        });
      });
    });

    group('フランス語', () {
      testWidgets('今日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'fr', (context) {
          dateHelper.setup('fr');
          expect(
              dateHelper.formatDateTime(testDates.today, false, context, showToday: true),
              'Aujourd9ui');
          expect(
              dateHelper.formatDateTime(testDates.today, true, context, showToday: true),
              'Aujourd9ui');
          expect(
              dateHelper.formatDateTime(testDates.today, false, context,
                  showToday: false),
              '9:09');
        });
      });

      testWidgets('昨日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'fr', (context) {
          dateHelper.setup('fr');
          expect(dateHelper.formatDateTime(testDates.yesterday, false, context),
              'Hier 9:09');
          expect(dateHelper.formatDateTime(testDates.yesterday, true, context), 'Hier');
        });
      });

      testWidgets('明日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'fr', (context) {
          dateHelper.setup('fr');
          expect(dateHelper.formatDateTime(testDates.tomorrow, false, context),
              'Demain 9:09');
          expect(dateHelper.formatDateTime(testDates.tomorrow, true, context), 'Demain');
        });
      });

      testWidgets('1週間以内の未来の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'fr', (context) {
          dateHelper.setup('fr');
          final threeDaysLater = testDates.now.add(const Duration(days: 3));
          final otherDay = DateTime(threeDaysLater.year, threeDaysLater.month,
              threeDaysLater.day, 10, 30);
          expect(dateHelper.formatDateTime(otherDay, false, context),
              'lun. 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), 'lun.');
        });
      });

      testWidgets('過去の日付（同じ月）', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'fr', (context) {
          dateHelper.setup('fr');
          final threeDaysAgo = testDates.now.add(const Duration(days: -3));
          final otherDay = DateTime(
              threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 10, 30);
          expect(dateHelper.formatDateTime(otherDay, false, context),
              '12 mars 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), '12 mars');
        });
      });

      testWidgets('1週間を超える日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'fr', (context) {
          dateHelper.setup('fr');
          final tenDaysLater = testDates.now.add(const Duration(days: 10));
          final futureDay = DateTime(
              tenDaysLater.year, tenDaysLater.month, tenDaysLater.day, 10, 30);
          expect(dateHelper.formatDateTime(futureDay, false, context),
              '25 mars 10:30');
          expect(dateHelper.formatDateTime(futureDay, true, context), '25 mars');
        });
      });

      testWidgets('来月の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'fr', (context) {
          dateHelper.setup('fr');
          expect(dateHelper.formatDateTime(testDates.nextMonth, false, context),
              '1 avr. 9:09');
          expect(dateHelper.formatDateTime(testDates.nextMonth, true, context), '1 avr.');
        });
      });

      testWidgets('来年の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'fr', (context) {
          dateHelper.setup('fr');
          expect(dateHelper.formatDateTime(testDates.nextYear, false, context),
              '1 janv. 2025 9:09');
          expect(dateHelper.formatDateTime(testDates.nextYear, true, context), '1 janv. 2025');
        });
      });
    });

    group('ドイツ語', () {
      testWidgets('今日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'de', (context) {
          dateHelper.setup('de');
          expect(
              dateHelper.formatDateTime(testDates.today, false, context, showToday: true),
              'Heute 9:09');
          expect(
              dateHelper.formatDateTime(testDates.today, true, context, showToday: true),
              'Heute');
          expect(
              dateHelper.formatDateTime(testDates.today, false, context,
                  showToday: false),
              '9:09');
        });
      });

      testWidgets('昨日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'de', (context) {
          dateHelper.setup('de');
          expect(dateHelper.formatDateTime(testDates.yesterday, false, context),
              'Gestern 9:09');
          expect(
              dateHelper.formatDateTime(testDates.yesterday, true, context), 'Gestern');
        });
      });

      testWidgets('明日の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'de', (context) {
          dateHelper.setup('de');
          expect(dateHelper.formatDateTime(testDates.tomorrow, false, context),
              'Morgen 9:09');
          expect(dateHelper.formatDateTime(testDates.tomorrow, true, context), 'Morgen');
        });
      });

      testWidgets('1週間以内の未来の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'de', (context) {
          dateHelper.setup('de');
          final threeDaysLater = testDates.now.add(const Duration(days: 3));
          final otherDay = DateTime(threeDaysLater.year, threeDaysLater.month,
              threeDaysLater.day, 10, 30);
          expect(
              dateHelper.formatDateTime(otherDay, false, context), 'Mo. 10:30');
          expect(dateHelper.formatDateTime(otherDay, true, context), 'Mo');
        });
      });

      testWidgets('過去の日付（同じ月）', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'de', (context) {
          dateHelper.setup('de');
          final threeDaysAgo = testDates.now.add(const Duration(days: -3));
          final otherDay = DateTime(
              threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 10, 30);
          expect(dateHelper.formatDateTime(otherDay, false, context),
              '12. März 10:30');
          expect(
              dateHelper.formatDateTime(otherDay, true, context), '12. März');
        });
      });

      testWidgets('1週間を超える日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'de', (context) {
          dateHelper.setup('de');
          final tenDaysLater = testDates.now.add(const Duration(days: 10));
          final futureDay = DateTime(
              tenDaysLater.year, tenDaysLater.month, tenDaysLater.day, 10, 30);
          expect(dateHelper.formatDateTime(futureDay, false, context),
              '25. März 10:30');
          expect(dateHelper.formatDateTime(futureDay, true, context), '25. März');
        });
      });

      testWidgets('来月の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'de', (context) {
          dateHelper.setup('de');
          expect(dateHelper.formatDateTime(testDates.nextMonth, false, context),
              '1. Apr. 9:09');
          expect(dateHelper.formatDateTime(testDates.nextMonth, true, context), '1. Apr.');
        });
      });

      testWidgets('来年の日付', (WidgetTester tester) async {
        await testFormatDateTime(tester, 'de', (context) {
          dateHelper.setup('de');
          expect(dateHelper.formatDateTime(testDates.nextYear, false, context),
              '1. Jan. 2025 9:09');
          expect(dateHelper.formatDateTime(testDates.nextYear, true, context), '1. Jan. 2025');
        });
      });
    });
  });
}