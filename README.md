# EzEmailField

A drop-in Flutter `TextFormField` specifically designed for email input with built-in RFC 5322 validation, auto-trimming, mobile autofill, and quick clear support.

[![pub package](https://img.shields.io/pub/v/ez_email_field.svg)](https://pub.dev/packages/ez_email_field)
[![likes](https://img.shields.io/pub/likes/ez_email_field.svg)](https://pub.dev/packages/ez_email_field)
[![popularity](https://img.shields.io/pub/popularity/ez_email_field.svg)](https://pub.dev/packages/ez_email_field)
[![pub points](https://img.shields.io/pub/points/ez_email_field.svg)](https://pub.dev/packages/ez_email_field)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Problem Statement

Implementing email fields repeatedly in Flutter requires boilerplate that is prone to common edge-case defects:

1. **Regex Errors & Copy-Paste Defects:** Writing or finding regex patterns that comply with standard email formatting while handling domain lengths and international characters.
2. **Whitespace Bugs:** Mobile keyboards often insert trailing whitespace when using autocomplete, voice dictation, or clipboard paste, causing valid emails to fail validation.
3. **Missing OS Autofill:** Forgetting `autofillHints: const [AutofillHints.email]` breaks password managers and OS credential managers on iOS, Android, and web.
4. **Boilerplate Clear Buttons:** Managing text editing controllers and state just to toggle a clear button icon on text entry.

### Targeted Error Signatures & Defects
* `"Invalid email address"` / `"Enter a valid email"`
* False negative validation errors caused by pasted trailing whitespace
* Missing browser and OS password manager suggestions (`AutofillHints.email`)

## Technical Solution

`EzEmailField` provides a complete drop-in replacement for `TextFormField` pre-configured with robust email defaults:

1. **Built-in RFC 5322 Validation:** Validates email format automatically using a thoroughly tested, performant regular expression.
2. **Automated Whitespace Trimming:** Automatically strips leading and trailing whitespace before validation and submission.
3. **Mobile Autofill Integration:** Configured with `AutofillHints.email` out of the box for iOS, Android, and web autofill services.
4. **Dynamic Clear Suffix Button:** Optional `showClearButton` toggle displaying a clear button when text is present.
5. **100% Drop-in Parity:** Supports all standard `TextFormField` properties (`validator`, `initialValue`, `focusNode`, `autovalidateMode`, `onSaved`, `inputFormatters`, etc.).
6. **Alias Support:** Includes `EZEmailField` typedef for backwards compatibility.

## Installation

```shell
flutter pub add ez_email_field
```

## Quick Migration

Replace standard `TextFormField` with `EzEmailField`:

```diff
- TextFormField(
-   keyboardType: TextInputType.emailAddress,
-   validator: (val) => val != null && !RegExp(r'...').hasMatch(val) ? 'Invalid email' : null,
+ EzEmailField(
    onSaved: (email) => _email = email,
  )
```

## Usage Examples

### 1. Basic Form Integration

```dart
Form(
  key: _formKey,
  child: Column(
    children: [
      EzEmailField(
        labelText: 'Email Address',
        showClearButton: true,
        onSaved: (val) => _email = val,
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
          }
        },
        child: const Text('Submit'),
      ),
    ],
  ),
)
```

### 2. Custom Error Messages

```dart
EzEmailField(
  requiredMessage: 'Please enter your email address to continue',
  invalidEmailMessage: 'The provided email address is not in a valid format',
)
```

### 3. Custom Domain Validation

Add extra rules on top of the built-in email format validation:

```dart
EzEmailField(
  validator: (email) {
    if (email != null && !email.endsWith('@company.com')) {
      return 'Only @company.com email addresses are permitted';
    }
    return null;
  },
)
```

## API Reference

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `controller` | `TextEditingController?` | `null` | Controls the text being edited. |
| `initialValue` | `String?` | `null` | Initial text value when no controller is provided. |
| `focusNode` | `FocusNode?` | `null` | Defines keyboard focus for the field. |
| `labelText` | `String?` | `'Email'` | Label text for input decoration. |
| `hintText` | `String?` | `null` | Hint text suggesting accepted format. |
| `required` | `bool` | `true` | Whether the field is required. |
| `requiredMessage` | `String?` | `null` | Error message when required field is empty. |
| `invalidEmailMessage` | `String` | `'Invalid email address'` | Error message when format check fails. |
| `showClearButton` | `bool` | `false` | Displays a clear icon button when text is entered. |
| `validator` | `FormFieldValidator<String>?` | `null` | Custom validator executed after built-in email validation passes. |
| `onChanged` | `ValueChanged<String>?` | `null` | Callback when text value changes. |
| `onSaved` | `FormFieldSetter<String>?` | `null` | Callback when enclosing form is saved. |
| `onFieldSubmitted` | `ValueChanged<String>?` | `null` | Callback when user presses the action button. |
| `autovalidateMode` | `AutovalidateMode?` | `null` | Autovalidation trigger mode. |
| `enabled` | `bool?` | `null` | Whether the input is enabled. |
| `readOnly` | `bool` | `false` | Whether the field is read-only. |
| `autofillHints` | `Iterable<String>?` | `[AutofillHints.email]` | Autofill hints for mobile/browser credential managers. |

## Sponsoring & Support

If this package saved you debugging time, consider supporting ongoing maintenance:
* [GitHub Sponsors](https://github.com/sponsors/Evgenii-Zinner/)
* [Thanks.dev](https://thanks.dev/u/gh/evgenii-zinner)
* [Buy Me a Coffee](https://buymeacoffee.com/evgeniizinner)

## License

MIT License. See [LICENSE](LICENSE) for details.
