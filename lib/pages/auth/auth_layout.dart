import 'package:first_app/components/back_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Shared frame for the auth pages: avatar, title, the form fields,
/// and a footer link to the other auth page.
class AuthLayout extends StatelessWidget {
  const new({
    super.key,
    required this.formKey,
    required this.title,
    required this.subtitle,
    required this.children,
    required this.footer,
  });

  final GlobalKey<FormState> formKey;
  final String title;
  final String subtitle;
  final List<Widget> children;
  final AuthSwitchLink footer;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  // Only when there's a page to go back to.
                  if (context.canPop()) const OutlinedBackButton(),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(subtitle, style: textTheme.bodyMedium),
                    ],
                  ),
                  ...children,
                  footer,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// "Don't have an account? Sign up" style link.
class AuthSwitchLink extends StatelessWidget {
  const new({
    super.key,
    required this.question,
    required this.action,
    required this.path,
  });

  final String question;
  final String action;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(question, style: TextStyle(color: Colors.grey[700])),
        TextButton(
          // Pushes so the page slides in and Back works. If we came from
          // the other auth page, go back to it instead of stacking a copy.
          onPressed: () =>
              context.canPop() ? context.pop() : context.push(path),
          child: Text(action),
        ),
      ],
    );
  }
}
