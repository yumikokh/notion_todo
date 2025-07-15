import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../lib/src/notion/model/task.dart';
import '../../../../../lib/src/notion/tasks/task_viewmodel.dart';
import '../../../../../lib/src/notion/tasks/view/task_actions_menu.dart';
import '../../../../../lib/generated/app_localizations.dart';

import 'task_actions_menu_test.mocks.dart';

@GenerateMocks([TaskViewModel])
void main() {
  group('TaskActionsMenu', () {
    late MockTaskViewModel mockTaskViewModel;
    late Task sampleTask;

    setUp(() {
      mockTaskViewModel = MockTaskViewModel();
      sampleTask = Task(
        id: 'test-task-id',
        title: 'Test Task',
        status: const TaskStatus.checkbox(checkbox: false),
        dueDate: null,
        url: 'https://notion.so/test-page',
        priority: null,
      );
    });

    Widget createTestApp(Widget child) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ProviderScope(
          child: Scaffold(
            body: child,
          ),
        ),
      );
    }

    testWidgets('TaskActionsMenu displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestApp(
          TaskActionsMenu(
            task: sampleTask,
            taskViewModel: mockTaskViewModel,
          ),
        ),
      );

      expect(find.byType(TaskActionsMenu), findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('Long press shows popup menu', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestApp(
          TaskActionsMenu(
            task: sampleTask,
            taskViewModel: mockTaskViewModel,
          ),
        ),
      );

      // Long press to trigger menu
      await tester.longPress(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Verify menu items are displayed
      expect(find.textContaining('Notion'), findsWidgets);
      expect(find.textContaining('Copy'), findsWidgets);
      expect(find.textContaining('Duplicate'), findsOneWidget);
      expect(find.textContaining('Open'), findsOneWidget);
    });

    testWidgets('Copy title functionality works', (WidgetTester tester) async {
      // Mock clipboard
      const channel = MethodChannel('flutter/platform');
      final List<MethodCall> log = <MethodCall>[];
      
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          log.add(methodCall);
          return null;
        },
      );

      await tester.pumpWidget(
        createTestApp(
          TaskActionsMenu(
            task: sampleTask,
            taskViewModel: mockTaskViewModel,
          ),
        ),
      );

      // Long press to show menu
      await tester.longPress(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Tap copy title
      await tester.tap(find.text('Copy Title'));
      await tester.pumpAndSettle();

      // Verify clipboard was called
      expect(log, hasLength(1));
      expect(log[0].method, 'Clipboard.setData');
      expect(log[0].arguments, {'text': 'Test Task'});
    });

    testWidgets('Copy notion link functionality works', (WidgetTester tester) async {
      // Mock clipboard
      const channel = MethodChannel('flutter/platform');
      final List<MethodCall> log = <MethodCall>[];
      
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          log.add(methodCall);
          return null;
        },
      );

      await tester.pumpWidget(
        createTestApp(
          TaskActionsMenu(
            task: sampleTask,
            taskViewModel: mockTaskViewModel,
          ),
        ),
      );

      // Long press to show menu
      await tester.longPress(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Tap copy notion link
      await tester.tap(find.text('Copy Notion Link'));
      await tester.pumpAndSettle();

      // Verify clipboard was called
      expect(log, hasLength(1));
      expect(log[0].method, 'Clipboard.setData');
      expect(log[0].arguments, {'text': 'https://notion.so/test-page'});
    });

    testWidgets('Duplicate task functionality works', (WidgetTester tester) async {
      when(mockTaskViewModel.addTask(any)).thenAnswer((_) async {});

      await tester.pumpWidget(
        createTestApp(
          TaskActionsMenu(
            task: sampleTask,
            taskViewModel: mockTaskViewModel,
          ),
        ),
      );

      // Long press to show menu
      await tester.longPress(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Tap duplicate
      await tester.tap(find.text('Duplicate'));
      await tester.pumpAndSettle();

      // Verify addTask was called
      verify(mockTaskViewModel.addTask(any)).called(1);
    });

    testWidgets('Handles task without notion link', (WidgetTester tester) async {
      final taskWithoutUrl = Task(
        id: 'test-task-id',
        title: 'Test Task',
        status: const TaskStatus.checkbox(checkbox: false),
        dueDate: null,
        url: null,
        priority: null,
      );

      await tester.pumpWidget(
        createTestApp(
          TaskActionsMenu(
            task: taskWithoutUrl,
            taskViewModel: mockTaskViewModel,
          ),
        ),
      );

      // Long press to show menu
      await tester.longPress(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Tap copy notion link
      await tester.tap(find.text('Copy Notion Link'));
      await tester.pumpAndSettle();

      // Verify error message is shown
      expect(find.text('Notion link not found'), findsOneWidget);
    });
  });
}