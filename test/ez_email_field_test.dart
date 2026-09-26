import 'package:ez_email_field/ez_email_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> enterText(WidgetTester tester, String text) async {
    await tester.enterText(find.byType(TextFormField), text);
    await tester.pump();
  }

  String? getErrorText(WidgetTester tester) {
    final textFormField = tester.widget<TextFormField>(
      find.byType(TextFormField),
    );
    return textFormField.validator!(textFormField.controller!.text);
  }

  group('EzEmailField', () {
    testWidgets('Widget renders correctly and displays default properties', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: Form(child: EzEmailField())),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);

      final inputDecorator = tester.widget<InputDecorator>(
        find.byType(InputDecorator),
      );
      final inputDecoration = inputDecorator.decoration;

      expect(inputDecoration.hintText, 'Enter your email address');
      expect(find.byIcon(Icons.email_outlined), findsOneWidget);
    });

    testWidgets('EZEmailField typedef provides backwards compatibility', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: Form(child: EZEmailField())),
        ),
      );

      expect(find.byType(EzEmailField), findsOneWidget);
    });

    testWidgets('Default validation: Required field check', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Form(
              child: EzEmailField(required: true, labelText: 'User Email'),
            ),
          ),
        ),
      );

      expect(getErrorText(tester), 'User Email is required.');

      await enterText(tester, 'test@example.com');
      expect(getErrorText(tester), null);
    });

    testWidgets('Default validation: Invalid email format check', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: Form(child: EzEmailField())),
        ),
      );

      await enterText(tester, 'testexample.com');
      expect(getErrorText(tester), 'Please enter a valid email address.');

      await enterText(tester, 'test@');
      expect(getErrorText(tester), 'Please enter a valid email address.');

      await enterText(tester, 'valid.user.123@sub.domain.co');
      expect(getErrorText(tester), null);
    });

    testWidgets('Custom validator overrides default logic', (tester) async {
      const String customErrorMessage = 'This is a custom error.';
      String? customValidator(String? value) {
        if (value != null && value.contains('badword')) {
          return customErrorMessage;
        }
        return null;
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(child: EzEmailField(customValidator: customValidator)),
          ),
        ),
      );

      await enterText(tester, 'badword@test.com');
      expect(getErrorText(tester), customErrorMessage);

      await enterText(tester, 'gooduser@test.com');
      expect(getErrorText(tester), null);

      await enterText(tester, '');
      expect(getErrorText(tester), null);
    });

    testWidgets('Standard validator parameter works as drop-in replacement', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: EzEmailField(
                validator: (value) =>
                    value == 'blocked@test.com' ? 'Blocked' : null,
              ),
            ),
          ),
        ),
      );

      await enterText(tester, 'blocked@test.com');
      expect(getErrorText(tester), 'Blocked');

      await enterText(tester, 'ok@test.com');
      expect(getErrorText(tester), null);
    });

    testWidgets('Custom requiredMessage and invalidEmailMessage', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Form(
              child: EzEmailField(
                required: true,
                requiredMessage: 'Email cannot be blank',
                invalidEmailMessage: 'Malformed email',
              ),
            ),
          ),
        ),
      );

      expect(getErrorText(tester), 'Email cannot be blank');

      await enterText(tester, 'not-an-email');
      expect(getErrorText(tester), 'Malformed email');

      await enterText(tester, 'test@example.com');
      expect(getErrorText(tester), null);
    });

    testWidgets('autoTrim: true trims leading/trailing whitespace on validate',
        (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Form(
              child: EzEmailField(autoTrim: true),
            ),
          ),
        ),
      );

      // Trailing/leading spaces should not fail validation
      await enterText(tester, '  user@example.com  ');
      expect(getErrorText(tester), null);

      // Only spaces should fail required validation
      await enterText(tester, '   ');
      expect(getErrorText(tester), 'Email is required.');
    });

    testWidgets('autoTrim: false preserves spaces causing validation failure', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Form(
              child: EzEmailField(autoTrim: false),
            ),
          ),
        ),
      );

      await enterText(tester, ' user@example.com ');
      expect(getErrorText(tester), 'Please enter a valid email address.');
    });

    testWidgets('Custom emailRegex overrides default regex', (tester) async {
      final customRegex = RegExp(r'^.*admin.*\.org$');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(child: EzEmailField(emailRegex: customRegex)),
          ),
        ),
      );

      await enterText(tester, 'user@test.com');
      expect(getErrorText(tester), 'Please enter a valid email address.');

      await enterText(tester, 'superadmin@test.org');
      expect(getErrorText(tester), null);
    });

    testWidgets('onChanged callback works', (tester) async {
      String lastValue = '';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: EzEmailField(
                onChanged: (value) {
                  lastValue = value;
                },
              ),
            ),
          ),
        ),
      );

      await enterText(tester, 'hello');
      expect(lastValue, 'hello');

      await enterText(tester, 'test@');
      expect(lastValue, 'test@');
    });

    testWidgets('readOnly property prevents text entry', (tester) async {
      final controller = TextEditingController(text: 'initial@email.com');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: EzEmailField(readOnly: true, controller: controller),
            ),
          ),
        ),
      );

      await enterText(tester, 'newtext@example.com');
      expect(controller.text, 'initial@email.com');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: EzEmailField(readOnly: false, controller: controller),
            ),
          ),
        ),
      );

      await enterText(tester, 'another@email.com');
      expect(controller.text, 'another@email.com');
    });

    testWidgets('initialValue sets initial text without external controller', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Form(
              child: EzEmailField(initialValue: 'preset@domain.com'),
            ),
          ),
        ),
      );

      expect(find.text('preset@domain.com'), findsOneWidget);
    });

    testWidgets(
        'showClearButton displays clear icon when text exists and clears', (
      tester,
    ) async {
      String changedText = '';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: EzEmailField(
                showClearButton: true,
                onChanged: (val) => changedText = val,
              ),
            ),
          ),
        ),
      );

      // Initially empty, no clear icon
      expect(find.byIcon(Icons.clear), findsNothing);

      // Enter text, clear icon appears
      await enterText(tester, 'user@test.com');
      expect(find.byIcon(Icons.clear), findsOneWidget);

      // Tap clear icon
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();

      expect(find.text('user@test.com'), findsNothing);
      expect(changedText, '');
      expect(find.byIcon(Icons.clear), findsNothing);
    });

    testWidgets('onSaved trims value when autoTrim is true', (tester) async {
      final formKey = GlobalKey<FormState>();
      String? savedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: EzEmailField(
                autoTrim: true,
                onSaved: (val) => savedValue = val,
              ),
            ),
          ),
        ),
      );

      await enterText(tester, '  save@test.com  ');
      formKey.currentState!.save();

      expect(savedValue, 'save@test.com');
    });

    testWidgets('onFieldSubmitted trims value when autoTrim is true', (
      tester,
    ) async {
      String? submittedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: EzEmailField(
                autoTrim: true,
                onFieldSubmitted: (val) => submittedValue = val,
              ),
            ),
          ),
        ),
      );

      await enterText(tester, '  submitted@test.com  ');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(submittedValue, 'submitted@test.com');
    });

    testWidgets('autofillHints default to [AutofillHints.email]', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: Form(child: EzEmailField())),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.autofillHints, contains(AutofillHints.email));
    });

    testWidgets('decoration override preserves custom border and prefixIcon', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Form(
              child: EzEmailField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.alternate_email),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.alternate_email), findsOneWidget);
      expect(find.byIcon(Icons.email_outlined), findsNothing);

      final inputDecorator = tester.widget<InputDecorator>(
        find.byType(InputDecorator),
      );
      expect(inputDecorator.decoration.border, isA<UnderlineInputBorder>());
    });
  });
}
