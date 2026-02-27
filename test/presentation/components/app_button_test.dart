import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kawanlama/presentation/components/app_button.dart';

void main() {
  group('AppButton Widget Tests', () {
    testWidgets('AppButton.defaults renders title and taps correctly',
        (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.defaults(
              title: 'Default Button',
              onPressed: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      final titleFinder = find.text('Default Button');
      expect(titleFinder, findsOneWidget);

      await tester.tap(titleFinder);
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('AppButton.defaults disabled state',
        (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.defaults(
              title: 'Disabled Button',
              enabled: false,
              onPressed: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      final buttonFinder = find.byType(ElevatedButton);
      expect(tester.widget<ElevatedButton>(buttonFinder).enabled, isFalse);

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      expect(tapped, isFalse);
    });

    testWidgets('AppButton.inverted renders correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.inverted(
              title: 'Inverted Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      final titleFinder = find.text('Inverted Button');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('AppButton.text renders correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.text(
              title: 'Text Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      final titleFinder = find.text('Text Button');
      final buttonFinder = find.byType(TextButton);

      expect(titleFinder, findsOneWidget);
      expect(buttonFinder, findsOneWidget);
    });
  });
}
