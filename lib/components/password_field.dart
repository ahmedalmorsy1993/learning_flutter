import 'package:first_app/components/input_field.dart';
import 'package:first_app/core/validation/validators.dart';
import 'package:flutter/material.dart';

/// [InputField] with a built-in show/hide toggle.
class PasswordField extends StatefulWidget {
  const new({
    super.key,
    this.label = 'Password',
    this.hintText = 'Enter Your Password',
    this.controller,
    this.validators = const [],
    this.textInputAction,
    this.onFieldSubmitted,
    this.autofillHints = const [AutofillHints.password],
  });

  final String label;
  final String hintText;
  final TextEditingController? controller;
  final List<Validator> validators;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final Iterable<String>? autofillHints;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return InputField(
      label: widget.label,
      controller: widget.controller,
      obscureText: _obscure,
      validators: widget.validators,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      autofillHints: widget.autofillHints,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}
