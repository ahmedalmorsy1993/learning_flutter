import 'package:first_app/components/back_button.dart';
import 'package:first_app/components/input_field.dart';
import 'package:first_app/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const new({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscurePassword = true;
  GlobalKey<FormState> formState = GlobalKey();
  Widget get _passwordToggle => IconButton(
    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
    icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: [
            Form(
              key: formState,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  OutlinedBackButton(),
                  Center(
                    child: Container(
                      width: 150,
                      height: 150,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'images/ai_me.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text('Login to continue using the app'),
                    ),
                  ),
                  InputField(
                    label: 'Email',
                    decoration: InputDecoration(hintText: 'Enter Your Email'),
                  ),
                  InputField(
                    label: 'Password',
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Password',
                      suffixIcon: _passwordToggle,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.go('/signup'),
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                  ),
                  PrimaryButton(
                    text: 'Login',
                    onPressed: () {},
                    isLoading: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
