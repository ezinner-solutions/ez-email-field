# EZ Email Field

A **pre-validated, developer-friendly** Flutter text field specifically designed for email input.

## 🛑 The Problem

Implementing email fields repeatedly involves:
1.  **Regex Boilerplate:** Copy-pasting the same email regex pattern into every form.
2.  **Validation Logic:** Writing the same `if (value.isEmpty) ... else if (!regex.hasMatch) ...` logic.
3.  **Inconsistent UX:** Different parts of the app might accept different email formats or show different error messages.

## ✅ The EZ Solution

`EZEmailField` encapsulates best practices for email input into a single, drop-in widget:
-   **Built-in Validation:** Comes with a robust, industry-standard regex for email validation out of the box.
-   **Defensive Defaults:** Handles empty states and formatting errors automatically.
-   **Unified UX:** Ensures email input behaves consistently across your entire application.

## ✨ Features

*   **Zero-Config Validation:** Just drop it in a `Form`, and it works.
*   **Customizable Regex:** Use the default pattern or supply your own `emailRegex`.
*   **Flexible Styling:** Supports all standard `InputDecoration` properties.
*   **Controller Support:** Works with or without an external `TextEditingController`.

## 📦 Installation

```shell
flutter pub add ez_email_field
```

## 🚀 Usage

Wrap it in a `Form` to enable validation:

```dart
Form(
  key: _formKey,
  child: Column(
    children: [
      EZEmailField(
        controller: _emailController,
        decoration: InputDecoration(labelText: 'Email Address'),
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
             // Handle valid submission
          }
        },
        child: Text('Submit'),
      )
    ],
  ),
)
```

### Custom Validation Logic
You can still add custom logic on top of the built-in validation:

```dart
EZEmailField(
  customValidator: (value) {
    if (value != null && !value.endsWith('@company.com')) {
      return 'Corporate email required';
    }
    return null;
  },
)
```

## 🤝 Contributing

Contributions are welcome! Please feel free to open an issue or submit a pull request on [GitHub](https://github.com/Evgenii-Zinner/ez_email_field).

## 📜 License

MIT License - see the [LICENSE](LICENSE) file for details.
