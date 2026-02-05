import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/buttons/wizard_continue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WizardContinueButton', () {
    testWidgets('should render button with text', (tester) async {
      // Arrange
      const buttonText = 'Continue';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WizardContinueButton(
              text: buttonText,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(buttonText), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      // Arrange
      var callbackExecuted = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WizardContinueButton(
              text: 'Test',
              onPressed: () {
                callbackExecuted = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Assert
      expect(callbackExecuted, true);
    });

    testWidgets('should show loading indicator when isLoading is true',
        (tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WizardContinueButton(
              text: 'Test',
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Test'), findsNothing);
    });

    testWidgets('should be disabled when isLoading is true', (tester) async {
      // Arrange
      var wasPressed = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WizardContinueButton(
              text: 'Test',
              onPressed: () => wasPressed = true,
              isLoading: true,
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );

      // Assert
      expect(button.onPressed, null);
      expect(wasPressed, false);
    });

    testWidgets('should be enabled when isLoading is false', (tester) async {
      // Arrange
      var callbackExecuted = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WizardContinueButton(
              text: 'Test',
              onPressed: () {
                callbackExecuted = true;
              },
              isLoading: false,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Assert
      expect(callbackExecuted, true);
    });

    testWidgets('should be disabled when onPressed is null', (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WizardContinueButton(
              text: 'Test',
              onPressed: null,
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );

      // Assert
      expect(button.onPressed, null);
    });
  });
}
