import 'package:flutter/material.dart';

/// Full-width filled button with the app's default look.
///
/// Anything set in [style] overrides the matching default.
/// Pass `onPressed: null` to show it disabled.
/// Set [isLoading] to show a spinner and block taps.
class PrimaryButton extends StatelessWidget {
  const new({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.style,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonStyle? style;

  static final _defaultStyle = FilledButton.styleFrom(
    minimumSize: const Size.fromHeight(50),
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    disabledBackgroundColor: Colors.blue.shade200,
    disabledForegroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      style: style?.merge(_defaultStyle) ?? _defaultStyle,
      child: isLoading
          ? const SizedBox.square(
              dimension: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Colors.white,
              ),
            )
          : Text(text),
    );
  }
}
