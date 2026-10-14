import 'package:first_app/core/validation/validators.dart';
import 'package:flutter/material.dart';

/// Text field with the app's default look.
///
/// [label] is shown above the field (it never floats inside it).
/// Anything set in [decoration] overrides the matching default;
/// everything left unset falls back to [_defaults].
class InputField extends StatelessWidget {
  const new({
    super.key,
    this.label,
    this.controller,
    this.decoration,
    this.validators = const [],
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
  });

  final String? label;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final List<Validator> validators;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;

  static final _defaults = InputDecorationThemeData(
    filled: true,
    fillColor: Colors.grey[100],
    hintStyle: TextStyle(color: Colors.grey[700]),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(color: Colors.grey.shade500),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final field = TextFormField(
      controller: controller,
      validator: Validators.compose(validators),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      decoration: (decoration ?? const InputDecoration()).applyDefaults(
        _defaults,
      ),
    );

    if (label == null) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          label!,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        field,
      ],
    );
  }
}
