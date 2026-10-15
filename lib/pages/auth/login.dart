import 'package:first_app/components/input_field.dart';
import 'package:first_app/components/password_field.dart';
import 'package:first_app/components/primary_button.dart';
import 'package:first_app/core/dependencies.dart';
import 'package:first_app/core/ui/app_messenger.dart';
import 'package:first_app/core/validation/validators.dart';
import 'package:first_app/features/auth/data/auth_repository.dart';
import 'package:first_app/pages/auth/auth_layout.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  /// Tests can pass a fake [repository];
  /// the app uses the real one from `dependencies.dart`.
  const new({super.key, this.repository});

  final AuthRepository? repository;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  late final _auth = widget.repository ?? authRepository;
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      // No navigation here: the router's redirect sends the user home.
      await _auth.signIn(email: _email.text.trim(), password: _password.text);
      AppMessenger.success('Welcome back!');
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
      title: 'Login',
      subtitle: 'Login to continue using the app',
      footer: const AuthSwitchLink(
        question: "Don't have an account?",
        action: 'Sign up',
        path: '/signup',
      ),
      children: [
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
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _submit(),
          validators: [Validators.required(), Validators.minLength(8)],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Forgot your password?',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ),
        PrimaryButton(text: 'Login', onPressed: _submit, isLoading: _loading),
      ],
    );
  }
}
