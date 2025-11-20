import 'package:flutter/material.dart';

/// A pre-configured [TextFormField] designed specifically for collecting and validating email addresses.
///
/// Features:
/// *   **Built-in Validation:** Uses a robust regex to validate email formats automatically.
/// *   **Customizable:** Supports custom validators, regex, and full [InputDecoration] styling.
/// *   **Developer Friendly:** Handles common boilerplate like keyboard type and text input action.
class EZEmailField extends StatefulWidget {
  /// The text to display as the field's label. Defaults to 'Email'.
  final String labelText;

  /// The text to display when the field is empty. Defaults to 'Enter your email address'.
  final String hintText;

  /// Whether the field is required. If true, validation ensures the field is not empty.
  final bool required;

  /// Callback function to execute when the text in the field changes.
  final ValueChanged<String>? onChanged;

  /// An external controller to manage the text field's content.
  final TextEditingController? controller;

  /// Custom decoration to override the default styling.
  final InputDecoration? decoration;

  // --- Customization Properties ---

  /// Optional custom validator function. If provided, it overrides the default email validation.
  final FormFieldValidator<String>? customValidator;

  /// Optional custom RegExp for email validation. If provided, it replaces the default complex regex.
  final RegExp? emailRegex;

  // Core TextFormField properties
  final bool readOnly;
  final bool autofocus;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onEditingComplete;

  /// Creates an EZ Email Field widget.
  const EZEmailField({
    super.key,
    this.labelText = 'Email',
    this.hintText = 'Enter your email address',
    this.required = true,
    this.onChanged,
    this.controller,
    this.decoration,
    // Customization
    this.customValidator,
    this.emailRegex,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.style,
    this.textAlign = TextAlign.start,
    this.textInputAction,
    this.keyboardType,
    this.onFieldSubmitted,
    this.onEditingComplete,
  });

  @override
  State<EZEmailField> createState() => _EZEmailFieldState();
}

class _EZEmailFieldState extends State<EZEmailField> {
  // Use a local controller if one isn't provided by the user
  late final TextEditingController _controller;

  // Optimized: Define the regex once to avoid recompiling on every validation.
  static final _defaultEmailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$",
  );

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    // Only dispose the controller if it was created locally by this widget
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  /// Internal validation logic for email addresses.
  String? _validateEmail(String? value) {
    // 1. If a custom validator is provided, use it immediately.
    if (widget.customValidator != null) {
      return widget.customValidator!(value);
    }

    // 2. Default required check
    if (value == null || value.isEmpty) {
      return widget.required ? '${widget.labelText} is required.' : null;
    }

    // 3. Email format validation using custom or default regex
    final emailRegex = widget.emailRegex ?? _defaultEmailRegex;

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    // THIS IS THE FIX:
    // Start with the user's decoration, or an empty one if it's null.
    final userDecoration = widget.decoration ?? const InputDecoration();

    // Create the final decoration by using copyWith. This takes the user's
    // decoration and fills in any unspecified properties with our defaults.
    final finalDecoration = userDecoration.copyWith(
      labelText: userDecoration.labelText ?? widget.labelText,
      hintText: userDecoration.hintText ?? widget.hintText,
      border: userDecoration.border ??
          const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
      prefixIcon: userDecoration.prefixIcon ?? const Icon(Icons.email_outlined),
      contentPadding: userDecoration.contentPadding ??
          const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
    );

    return TextFormField(
      // State/Controller
      controller: _controller,
      onChanged: widget.onChanged,
      validator: _validateEmail,

      // Core TextFormField Overrides
      keyboardType: widget.keyboardType ?? TextInputType.emailAddress,
      autocorrect: false,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      style: widget.style ?? const TextStyle(fontSize: 16.0),
      textAlign: widget.textAlign,

      // Additional Exposed Properties
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      obscureText: widget.obscureText,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      onFieldSubmitted: widget.onFieldSubmitted,
      onEditingComplete: widget.onEditingComplete,

      decoration: finalDecoration,
    );
  }
}
