import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A pre-configured, self-validating [TextFormField] designed specifically
/// for collecting and validating email addresses.
///
/// [EzEmailField] provides a complete drop-in replacement for [TextFormField]
/// with smart email defaults:
///
/// * **Automatic Validation:** Uses a robust RFC 5322-compatible regex to validate
///   email formats out of the box.
/// * **Auto-trimming:** By default, trims leading and trailing whitespace so
///   accidental spaces from mobile auto-correct or paste don't fail validation.
/// * **Autofill Integration:** Pre-configured with [AutofillHints.email] so iOS,
///   Android, and password managers can automatically suggest saved email addresses.
/// * **Optional Clear Button:** Built-in clear suffix icon that appears when text
///   is present to quickly clear the field.
/// * **Material 3 Defaults:** Includes an email prefix icon, rounded border,
///   and clean padding while remaining fully customizable via [InputDecoration].
/// * **100% Drop-in Parity:** Supports [validator], [initialValue], [focusNode],
///   [autovalidateMode], [onSaved], [inputFormatters], and all standard
///   [TextFormField] properties.
///
/// ## Examples
///
/// ### Basic Usage
///
/// ```dart
/// EzEmailField(
///   onChanged: (email) => print('Email: $email'),
/// )
/// ```
///
/// ### With Form Validation & Clear Button
///
/// ```dart
/// EzEmailField(
///   labelText: 'Work Email',
///   showClearButton: true,
///   autovalidateMode: AutovalidateMode.onUserInteraction,
///   onSaved: (email) => _submitEmail(email),
/// )
/// ```
///
/// See also:
///
///  * [TextFormField], the underlying Flutter form field widget.
///  * [EzPasswordField], the companion defensive password field widget.
class EzEmailField extends StatefulWidget {
  /// The text to display as the field's label. Defaults to `'Email'`.
  final String labelText;

  /// The text to display when the field is empty. Defaults to `'Enter your email address'`.
  final String hintText;

  /// Whether the field is required. If `true`, validation ensures the field is not empty.
  ///
  /// Defaults to `true`.
  final bool required;

  /// Custom error message to display when the field is required but left empty.
  ///
  /// If `null`, defaults to `'${labelText} is required.'`.
  final String? requiredMessage;

  /// Custom error message to display when the email format does not match the regex.
  ///
  /// If `null`, defaults to `'Please enter a valid email address.'`.
  final String? invalidEmailMessage;

  /// Whether to automatically trim leading and trailing whitespace during validation,
  /// submission, and saving.
  ///
  /// Defaults to `true`.
  final bool autoTrim;

  /// Whether to show a clear button suffix icon when the field has text.
  ///
  /// Defaults to `false`.
  final bool showClearButton;

  /// Custom widget to use as the clear button icon.
  ///
  /// If `null`, defaults to `Icon(Icons.clear, size: 20)`.
  final Widget? clearIcon;

  /// Callback invoked whenever the text in the field changes.
  final ValueChanged<String>? onChanged;

  /// An external controller to manage the text field's content.
  final TextEditingController? controller;

  /// Initial text value to populate the field with if no [controller] is provided.
  final String? initialValue;

  /// Defines the keyboard focus for this widget.
  final FocusNode? focusNode;

  /// Custom decoration to style the field.
  ///
  /// Properties specified here will take precedence over [labelText], [hintText],
  /// and the default email prefix icon.
  final InputDecoration? decoration;

  /// Optional validator function. If provided, overrides the default email validation.
  final FormFieldValidator<String>? validator;

  /// Backwards-compatible alias for [validator].
  final FormFieldValidator<String>? customValidator;

  /// Optional custom [RegExp] for email validation.
  ///
  /// If provided, replaces the default RFC 5322 regex.
  final RegExp? emailRegex;

  /// Whether the text can be changed. Defaults to `false`.
  final bool readOnly;

  /// Whether this field should focus automatically. Defaults to `false`.
  final bool autofocus;

  /// Whether to hide the text being edited. Defaults to `false`.
  final bool obscureText;

  /// The maximum number of lines for the field. Defaults to `1`.
  final int? maxLines;

  /// The minimum number of lines for the field.
  final int? minLines;

  /// The maximum number of characters to allow in the field.
  final int? maxLength;

  /// The style to use for the text being edited.
  final TextStyle? style;

  /// How the text should be aligned horizontally. Defaults to [TextAlign.start].
  final TextAlign textAlign;

  /// The type of action button to use for the keyboard. Defaults to [TextInputAction.next].
  final TextInputAction? textInputAction;

  /// The type of keyboard to use for editing the text. Defaults to [TextInputType.emailAddress].
  final TextInputType? keyboardType;

  /// Whether to enable autocorrection. Defaults to `false` for email fields.
  final bool autocorrect;

  /// Whether to show input suggestions. Defaults to `true`.
  final bool enableSuggestions;

  /// Configures how the platform keyboard will capitalize letters. Defaults to [TextCapitalization.none].
  final TextCapitalization textCapitalization;

  /// Used to enable/disable auto-validation and determine its trigger mode.
  final AutovalidateMode? autovalidateMode;

  /// Optional input formatters to apply as the user types.
  final List<TextInputFormatter>? inputFormatters;

  /// If `false`, the field will be disabled and ignore user interaction.
  final bool? enabled;

  /// Invoked when the user indicates they are done editing the text in the field.
  final ValueChanged<String>? onFieldSubmitted;

  /// Invoked when the user submits editing via the keyboard action button.
  final VoidCallback? onEditingComplete;

  /// Invoked when the form is saved via [FormState.save].
  final FormFieldSetter<String>? onSaved;

  /// Called when the user taps on this text field.
  final GestureTapCallback? onTap;

  /// Autofill hints to communicate the type of field to the operating system autofill service.
  ///
  /// Defaults to `const [AutofillHints.email]`.
  final Iterable<String>? autofillHints;

  /// Configures padding for the viewport when scrolling into view. Defaults to `EdgeInsets.all(20.0)`.
  final EdgeInsets scrollPadding;

  /// The color of the cursor.
  final Color? cursorColor;

  /// Creates a pre-configured, self-validating [EzEmailField].
  const EzEmailField({
    super.key,
    this.labelText = 'Email',
    this.hintText = 'Enter your email address',
    this.required = true,
    this.requiredMessage,
    this.invalidEmailMessage,
    this.autoTrim = true,
    this.showClearButton = false,
    this.clearIcon,
    this.onChanged,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.decoration,
    this.validator,
    this.customValidator,
    this.emailRegex,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.style,
    this.textAlign = TextAlign.start,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.emailAddress,
    this.autocorrect = false,
    this.enableSuggestions = true,
    this.textCapitalization = TextCapitalization.none,
    this.autovalidateMode,
    this.inputFormatters,
    this.enabled,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onSaved,
    this.onTap,
    this.autofillHints = const [AutofillHints.email],
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.cursorColor,
  });

  @override
  State<EzEmailField> createState() => _EzEmailFieldState();
}

class _EzEmailFieldState extends State<EzEmailField> {
  late TextEditingController _controller;
  bool _hasText = false;

  // Optimized RFC 5322-compatible regex compiled once.
  static final _defaultEmailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$",
  );

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _hasText = _controller.text.isNotEmpty;
    _controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(EzEmailField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller == null) {
        _controller.removeListener(_onTextChanged);
        _controller.dispose();
      } else {
        oldWidget.controller!.removeListener(_onTextChanged);
      }

      _controller =
          widget.controller ?? TextEditingController(text: widget.initialValue);
      _hasText = _controller.text.isNotEmpty;
      _controller.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (_hasText != hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  /// Internal validation logic for email addresses.
  String? _validateEmail(String? value) {
    // 1. If a custom validator is provided, use it immediately.
    final effectiveValidator = widget.validator ?? widget.customValidator;
    if (effectiveValidator != null) {
      return effectiveValidator(value);
    }

    final trimmed = widget.autoTrim ? value?.trim() : value;

    // 2. Default required check
    if (trimmed == null || trimmed.isEmpty) {
      return widget.required
          ? (widget.requiredMessage ?? '${widget.labelText} is required.')
          : null;
    }

    // 3. Email format validation using custom or default regex
    final emailRegex = widget.emailRegex ?? _defaultEmailRegex;

    if (!emailRegex.hasMatch(trimmed)) {
      return widget.invalidEmailMessage ??
          'Please enter a valid email address.';
    }

    return null;
  }

  Widget? _buildSuffixIcon(InputDecoration userDecoration) {
    if (userDecoration.suffixIcon != null) {
      return userDecoration.suffixIcon;
    }

    if (!widget.showClearButton ||
        widget.readOnly ||
        widget.enabled == false ||
        !_hasText) {
      return null;
    }

    return IconButton(
      icon: widget.clearIcon ?? const Icon(Icons.clear, size: 20),
      tooltip: 'Clear',
      onPressed: () {
        _controller.clear();
        widget.onChanged?.call('');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userDecoration = widget.decoration ?? const InputDecoration();

    final finalDecoration = userDecoration.copyWith(
      labelText: userDecoration.labelText ?? widget.labelText,
      hintText: userDecoration.hintText ?? widget.hintText,
      border: userDecoration.border ??
          const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
      prefixIcon: userDecoration.prefixIcon ?? const Icon(Icons.email_outlined),
      suffixIcon: _buildSuffixIcon(userDecoration),
      contentPadding: userDecoration.contentPadding ??
          const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
    );

    return TextFormField(
      controller: _controller,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      validator: _validateEmail,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      textCapitalization: widget.textCapitalization,
      autovalidateMode: widget.autovalidateMode,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      style: widget.style ?? const TextStyle(fontSize: 16.0),
      textAlign: widget.textAlign,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      obscureText: widget.obscureText,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      onFieldSubmitted: widget.onFieldSubmitted != null
          ? (value) => widget.onFieldSubmitted!(
                widget.autoTrim ? value.trim() : value,
              )
          : null,
      onEditingComplete: widget.onEditingComplete,
      onSaved: widget.onSaved != null
          ? (value) => widget.onSaved!(
                widget.autoTrim ? value?.trim() : value,
              )
          : null,
      onTap: widget.onTap,
      autofillHints: widget.autofillHints,
      scrollPadding: widget.scrollPadding,
      cursorColor: widget.cursorColor,
      decoration: finalDecoration,
    );
  }
}

/// Backwards-compatible alias for [EzEmailField].
typedef EZEmailField = EzEmailField;
