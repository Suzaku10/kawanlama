import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kawanlama/presentation/components/app_dialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

void main() {
  group('AppDialog Widget Tests', () {
    testWidgets(
        'AppDialog.showInfoInMd renders markdown and close button dismisses it',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              return Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      AppDialog.showInfoInMd(context,
                          info: '# Test Markdown\nThis is a test');
                    },
                    child: const Text('Show Dialog'),
                  ),
                ),
              );
            },
          ),
        ),
      );

      // Tap the button to show the dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Verify the dialog and markdown content are rendered
      expect(find.byType(Dialog), findsOneWidget);
      expect(find.byType(MarkdownBody), findsOneWidget);
      expect(find.text('Test Markdown'), findsOneWidget);
      expect(find.text('This is a test'), findsOneWidget);

      // Tap the close button
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // Verify the dialog is dismissed
      expect(find.byType(Dialog), findsNothing);
    });
  });
}
