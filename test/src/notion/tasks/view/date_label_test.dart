import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tanzaku_todo/src/notion/tasks/view/date_label.dart';
import 'package:tanzaku_todo/src/notion/model/task.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('en_US', null);
    await initializeDateFormatting('ja_JP', null);
  });
  group('DateLabel', () {
    // テスト用のウィジェットをラップするヘルパー関数
    Widget createTestWidget({
      required TaskDate? date,
      required bool showToday,
      bool showColor = true,
      bool showIcon = true,
    }) {
      return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ja', 'JP'),
        ],
        home: Scaffold(
          body: Builder(
            builder: (context) => DateLabel(
              date: date,
              showToday: showToday,
              context: context,
              showColor: showColor,
              showIcon: showIcon,
            ),
          ),
        ),
      );
    }

    testWidgets('単一の日付（終日）を表示', (WidgetTester tester) async {
      // 過去の日付を使用（今日として表示されないように）
      final date = TaskDate(
        start: NotionDateTime(
          datetime: DateTime(2024, 3, 15),
          isAllDay: true,
        ),
        end: null,
      );

      await tester.pumpWidget(createTestWidget(
        date: date,
        showToday: true,
      ));

      // 日付が表示されていることを確認（月日の形式）
      expect(find.textContaining('3'), findsOneWidget);
    });

    testWidgets('日付範囲（異なる日）を表示', (WidgetTester tester) async {
      final date = TaskDate(
        start: NotionDateTime(
          datetime: DateTime(2024, 3, 7, 12, 0),
          isAllDay: false,
        ),
        end: NotionDateTime(
          datetime: DateTime(2024, 3, 8, 18, 0),
          isAllDay: false,
        ),
      );

      await tester.pumpWidget(createTestWidget(
        date: date,
        showToday: true,
      ));

      // 矢印アイコンが表示されていることを確認（日付範囲の証拠）
      expect(find.byIcon(Icons.arrow_right_alt_rounded), findsOneWidget);
      // 開始日と終了日の両方が表示されていることを確認
      expect(find.byType(Text), findsNWidgets(2));
    });

    testWidgets('日付範囲（同じ日）の場合、終了時刻のみ表示', (WidgetTester tester) async {
      final date = TaskDate(
        start: NotionDateTime(
          datetime: DateTime(2024, 3, 8, 9, 0),
          isAllDay: false,
        ),
        end: NotionDateTime(
          datetime: DateTime(2024, 3, 8, 18, 0),
          isAllDay: false,
        ),
      );

      await tester.pumpWidget(createTestWidget(
        date: date,
        showToday: true,
      ));

      // 矢印アイコンが表示されていることを確認
      expect(find.byIcon(Icons.arrow_right_alt_rounded), findsOneWidget);
      // 時刻が2つ表示されていることを確認（開始時刻と終了時刻）
      expect(find.byType(Text), findsNWidgets(2));
    });

    testWidgets('showTodayがfalseの場合、今日の日付は表示されない', (WidgetTester tester) async {
      final today = DateTime.now();
      final date = TaskDate(
        start: NotionDateTime(
          datetime: DateTime(today.year, today.month, today.day),
          isAllDay: true,
        ),
        end: null,
      );

      await tester.pumpWidget(createTestWidget(
        date: date,
        showToday: false,
      ));

      // 今日の日付が表示されていないことを確認（何も表示されない）
      expect(find.text('Today'), findsNothing);
      expect(find.text('今日'), findsNothing);
    });

    testWidgets('showTodayがfalseでも時刻がある場合は時刻を表示', (WidgetTester tester) async {
      final today = DateTime.now();
      final date = TaskDate(
        start: NotionDateTime(
          datetime: DateTime(today.year, today.month, today.day, 14, 30),
          isAllDay: false,
        ),
        end: null,
      );

      await tester.pumpWidget(createTestWidget(
        date: date,
        showToday: false,
      ));

      // 時刻が表示されていることを確認
      expect(find.textContaining('14:30'), findsOneWidget);
    });

    testWidgets('dateがnullの場合、何も表示されない', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        date: null,
        showToday: true,
      ));

      // 何も表示されていないことを確認
      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('showIconがtrueの場合、アイコンが表示される', (WidgetTester tester) async {
      final date = TaskDate(
        start: NotionDateTime(
          datetime: DateTime(2025, 7, 8),
          isAllDay: true,
        ),
        end: null,
      );

      await tester.pumpWidget(createTestWidget(
        date: date,
        showToday: true,
        showIcon: true,
      ));

      // イベントアイコンが表示されていることを確認
      expect(find.byIcon(Icons.event_rounded), findsOneWidget);
    });

    testWidgets('showIconがfalseの場合、アイコンが表示されない', (WidgetTester tester) async {
      final date = TaskDate(
        start: NotionDateTime(
          datetime: DateTime(2025, 7, 8),
          isAllDay: true,
        ),
        end: null,
      );

      await tester.pumpWidget(createTestWidget(
        date: date,
        showToday: true,
        showIcon: false,
      ));

      // イベントアイコンが表示されていないことを確認
      expect(find.byIcon(Icons.event_rounded), findsNothing);
    });

    group('日付範囲の表示ロジック', () {
      testWidgets('昨日から今日の日付範囲で両方の日付が表示される', (WidgetTester tester) async {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        final today = DateTime.now();

        final date = TaskDate(
          start: NotionDateTime(
            datetime:
                DateTime(yesterday.year, yesterday.month, yesterday.day, 12, 0),
            isAllDay: false,
          ),
          end: NotionDateTime(
            datetime: DateTime(today.year, today.month, today.day, 6, 0),
            isAllDay: false,
          ),
        );

        await tester.pumpWidget(createTestWidget(
          date: date,
          showToday: true,
        ));

        // 矢印アイコンが表示されていることを確認
        expect(find.byIcon(Icons.arrow_right_alt_rounded), findsOneWidget);
        // 2つのテキストが表示されていることを確認（開始日と終了日）
        expect(find.byType(Text), findsNWidgets(2));
      });

      testWidgets('Todayページで昨日から今日の日付範囲表示（showToday=false）',
          (WidgetTester tester) async {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        final today = DateTime.now();

        final date = TaskDate(
          start: NotionDateTime(
            datetime:
                DateTime(yesterday.year, yesterday.month, yesterday.day, 12, 0),
            isAllDay: false,
          ),
          end: NotionDateTime(
            datetime: DateTime(today.year, today.month, today.day, 6, 0),
            isAllDay: false,
          ),
        );

        await tester.pumpWidget(createTestWidget(
          date: date,
          showToday: false,
        ));

        // 矢印アイコンが表示されていることを確認
        expect(find.byIcon(Icons.arrow_right_alt_rounded), findsOneWidget);
        // 2つのテキストが表示されていることを確認（開始日と終了時刻）
        expect(find.byType(Text), findsNWidgets(2));
      });

      testWidgets('終日タスクで同じ日の場合でもshowTodayがtrueなら今日を表示',
          (WidgetTester tester) async {
        final today = DateTime.now();

        final date = TaskDate(
          start: NotionDateTime(
            datetime: DateTime(today.year, today.month, today.day),
            isAllDay: true,
          ),
          end: NotionDateTime(
            datetime: DateTime(today.year, today.month, today.day),
            isAllDay: true,
          ),
        );

        await tester.pumpWidget(createTestWidget(
          date: date,
          showToday: false, // showTodayがfalseでも表示される
        ));

        // 矢印アイコンが表示されていることを確認
        expect(find.byIcon(Icons.arrow_right_alt_rounded), findsOneWidget);
        // テキストが表示されていることを確認
        expect(find.byType(Text), findsNWidgets(2));
      });
    });
  });
}
