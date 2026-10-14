import 'package:flutter/widgets.dart';

typedef Validator = FormFieldValidator<String>;

/// Reusable form-field validators.
///
/// Each method returns a validator, so you can combine them:
/// `validators: [Validators.required(), Validators.email()]`.
/// Every message can be overridden with `message:`.
abstract final class Validators {
  static final _emailRegex = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');

  static Validator required({String message = 'This field is required'}) =>
      (value) => (value == null || value.trim().isEmpty) ? message : null;

  /// Skips empty values so it can be combined with [required] or used alone
  /// on optional fields. The same applies to the other non-required rules.
  static Validator email({String message = 'Enter a valid email'}) =>
      (value) => _isEmpty(value) || _emailRegex.hasMatch(value!.trim())
      ? null
      : message;

  static Validator minLength(int length, {String? message}) =>
      (value) => _isEmpty(value) || value!.length >= length
      ? null
      : message ?? 'Must be at least $length characters';

  static Validator maxLength(int length, {String? message}) =>
      (value) => _isEmpty(value) || value!.length <= length
      ? null
      : message ?? 'Must be at most $length characters';

  static Validator pattern(RegExp regex, {required String message}) =>
      (value) => _isEmpty(value) || regex.hasMatch(value!) ? null : message;

  /// Checks the value equals another field's current value,
  /// e.g. `Validators.match(() => _password.text)` for "confirm password".
  static Validator match(
    String Function() other, {
    String message = 'Values do not match',
  }) =>
      (value) => value == other() ? null : message;

  /// Runs [validators] in order and returns the first error.
  static Validator compose(List<Validator> validators) => (value) {
    for (final validate in validators) {
      final error = validate(value);
      if (error != null) return error;
    }
    return null;
  };

  static bool _isEmpty(String? value) => value == null || value.isEmpty;
}
