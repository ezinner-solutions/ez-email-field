# EZ Email Field

A hassle-free Flutter package providing a highly customizable `TextFormField` specifically designed for email input, complete with built-in, robust validation.

## ✨ Features

*   **Built-in Validation:** Uses a comprehensive regex pattern for standard email format checks.
*   **Required Handling:** Easily mark the field as required or optional.
*   **Highly Customizable:**
    *   Override default labels, hints, and `InputDecoration` to match your app's theme.
    *   Provide a custom validator to override the default validation logic.
    *   Supply a custom `RegExp` for email validation.
*   **Clean API:** Simple constructor for quick integration.
*   **Controller Support:** Use your own `TextEditingController` or let the widget manage its own.

## 📦 Installation

Run this command in your terminal to add the package to your project:

```shell
flutter pub add ez_email_field
```

This will automatically add the package to your `pubspec.yaml` and run `flutter pub get`.

## 🚀 Usage

Wrap the `EZEmailField` within a `Form` widget to utilize the built-in validation features.

```dart
import 'package:flutter/material.dart';
import 'package:ez_email_field/ez_email_field.dart';

class EmailFormScreen extends StatefulWidget {
  const EmailFormScreen({super.key});

  @override
  State<EmailFormScreen> createState() => _EmailFormScreenState();
}

class _EmailFormScreenState extends State<EmailFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Validation passed! Proceed with submission logic.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email is valid!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EZ Email Field Demo')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Simple usage
              const EZEmailField(),
              const SizedBox(height: 20),

              // Custom usage with custom styling and label
              const EZEmailField(
                labelText: 'User ID Email',
                hintText: 'e.g., john.doe@work.com',
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  fillColor: Color(0xFFEBEBEB),
                  filled: true,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Validate & Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## 🎨 Customization

`EZEmailField` is designed to be highly customizable. Here are some of the properties you can use to tailor it to your needs:

| Property          | Description                                                                 |
| ----------------- | --------------------------------------------------------------------------- |
| `labelText`       | The text to display as the field's label.                                   |
| `hintText`        | The text to display when the field is empty.                                |
| `required`        | Whether the field is required.                                              |
| `controller`      | An external controller to manage the text field's content.                  |
| `decoration`      | Custom decoration to override the default styling.                          |
| `customValidator` | Optional custom validator function. Overrides the default email validation. |
| `emailRegex`      | Optional custom `RegExp` for email validation.                              |

### Example: Custom Validator

```dart
EZEmailField(
  customValidator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!value.endsWith('@example.com')) {
      return 'Only @example.com emails are allowed';
    }
    return null;
  },
)
```

## 🤝 Contributing

Contributions are welcome! If you have a feature request, bug report, or want to contribute to the code, please feel free to open an issue or submit a pull request on the [GitHub repository](https://github.com/Evgenii-Zinner/ez-email-field/).

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
