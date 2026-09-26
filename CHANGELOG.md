## 0.0.3

* **Feat:** Renamed primary class to `EzEmailField` to align with the `ez_flutter` ecosystem convention, with `typedef EZEmailField = EzEmailField;` for 100% backwards compatibility.
* **Feat:** Added `autoTrim` (enabled by default) to automatically strip leading and trailing whitespace on validation and form submission.
* **Feat:** Added `showClearButton` and `clearIcon` to provide an instant clear suffix action.
* **Feat:** Added `requiredMessage` and `invalidEmailMessage` for customizable validation error strings.
* **Feat:** Added full drop-in parity with Flutter's standard `TextFormField`:
  * Added `validator` alias for `customValidator`.
  * Added `initialValue`, `focusNode`, `autovalidateMode`, `enabled`, `onSaved`, `inputFormatters`, `onTap`, `cursorColor`, `textCapitalization`, and `maxLength`.
  * Added default `autofillHints: const [AutofillHints.email]` for native mobile autofill integration.
* **Tests:** Expanded test suite to 18 tests covering all new properties, auto-trim, and clear button behavior.

## 0.0.2

* **Docs:** Added `FUNDING.yml` and updated `pubspec.yaml` metadata.
* **Docs:** Refined `README.md` for better clarity and SEO.
* **Example:** Added comprehensive example app with Forms and validation.

## 0.0.1

* Initial release of the `ez_email_field` widget, a simple and customizable email input field.
