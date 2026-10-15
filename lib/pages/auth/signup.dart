import 'package:first_app/components/input_field.dart';
import 'package:first_app/components/password_field.dart';
import 'package:first_app/components/primary_button.dart';
import 'package:first_app/core/dependencies.dart';
import 'package:first_app/core/ui/app_messenger.dart';
import 'package:first_app/core/validation/validators.dart';
import 'package:first_app/features/auth/data/auth_repository.dart';
import 'package:first_app/pages/auth/auth_layout.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  /// Tests can pass a fake [repository];
  /// the app uses the real one from `dependencies.dart`.
  const new({super.key, this.repository});

  final AuthRepository? repository;

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  late final _auth = widget.repository ?? authRepository;
  bool _loading = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      // No navigation here: the router's redirect sends the user home.
      await _auth.signUp(
        name: _name.text.trim(),
        email: _email.text.trim(),
        password: _password.text,
      );
      AppMessenger.success('Account created. Welcome, ${_name.text.trim()}!');
    } on AuthException catch (e) {
      AppMessenger.error(e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      formKey: _formKey,
      title: 'Sign up',
      subtitle: 'Create an account to start using the app',
      footer: const AuthSwitchLink(
        question: 'Already have an account?',
        action: 'Login',
        path: '/login',
      ),
      children: [
        InputField(
          label: 'Name',
          controller: _name,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.name],
          validators: [Validators.required(), Validators.minLength(3)],
          decoration: const InputDecoration(hintText: 'Enter Your Name'),
        ),
        InputField(
          label: 'Email',
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.email],
          validators: [Validators.required(), Validators.email()],
          decoration: const InputDecoration(hintText: 'Enter Your Email'),
        ),
        PasswordField(
          controller: _password,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.newPassword],
          validators: [Validators.required(), Validators.minLength(8)],
        ),
        PasswordField(
          label: 'Confirm Password',
          hintText: 'Re-enter Your Password',
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.newPassword],
          onFieldSubmitted: (_) => _submit(),
          validators: [
            Validators.required(),
            Validators.match(
              () => _password.text,
              message: 'Passwords do not match',
            ),
          ],
        ),
        PrimaryButton(text: 'Sign up', onPressed: _submit, isLoading: _loading),
      ],
    );
  }
}
