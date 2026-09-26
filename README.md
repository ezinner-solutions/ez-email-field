# EzEmailField

A pre-configured, self-validating Flutter text field specifically designed for email input with built-in RFC 5322 validation, auto-trimming, mobile autofill, and quick clear support.

## 🛑 The Problem

Implementing email fields repeatedly in Flutter involves:
1. **Regex Boilerplate:** Copy-pasting regex patterns into every form.
2. **Whitespace Bugs:** Trailing spaces from mobile keyboard auto-correct or paste causing valid user emails to fail validation.
3. **Missing Autofill:** Forgetting `autofillHints`, preventing iOS/Android/password managers from suggesting saved emails.
4. **Boilerplate Clear Buttons & Styling:** Writing custom state management just to show/hide a clear button and styling borders.

## ✅ The EzEmailField Solution

`EzEmailField` provides a complete drop-in replacement for `TextFormField` with smart email defaults:

* **Zero-Config Validation:** Validates emails out of the box with an optimized RFC 5322-compatible regex.
* **Auto-trimming:** Automatically trims leading/trailing whitespace during validation and submission so users aren't tripped up by pasted spaces.
* **Mobile Autofill:** Pre-configured with `AutofillHints.email` for native autofill on iOS and Android.
* **Quick Clear Button:** Optional `showClearButton` toggle that displays a clear suffix icon when text is entered.
* **Drop-in Parity:** Supports all standard `TextFormField` properties (`validator`, `initialValue`, `focusNode`, `autovalidateMode`, `onSaved`, `inputFormatters`, etc.).
* **Backwards Compatible:** Includes `EZEmailField` alias so existing code continues to work seamlessly.

## 📦 Installation

```shell
flutter pub add ez_email_field
```

## 🚀 Usage

### Basic Usage

```dart
EzEmailField(
  onChanged: (email) => print('Typed: $email'),
)
```

### Inside a Form with Clear Button & Validation

```dart
Form(
  key: _formKey,
  autovalidateMode: AutovalidateMode.onUserInteraction,
  child: Column(
    children: [
      EzEmailField(
        labelText: 'Work Email',
        showClearButton: true,
        onSaved: (email) => _saveEmail(email),
      ),
      FilledButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
          }
        },
        child: const Text('Continue'),
      ),
    ],
  ),
)
```

### Custom Error Messages

```dart
EzEmailField(
  requiredMessage: 'Please enter your email address to continue',
  invalidEmailMessage: 'The email address format looks incorrect',
)
```

### Custom Validation Logic

Override default validation with domain restrictions or custom rules using `validator` (or `customValidator`):

```dart
EzEmailField(
  validator: (value) {
    if (value == null || !value.endsWith('@company.com')) {
      return 'Must be a @company.com email address';
    }
    return null;
  },
)
```

## 🤝 Contributing

Contributions, issues, and feature suggestions are always welcome! Check out the [GitHub repository](https://github.com/Evgenii-Zinner/ez-email-field).

## 📜 License

MIT License - see [LICENSE](LICENSE) for details.
