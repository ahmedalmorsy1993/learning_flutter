import 'package:flutter/material.dart';

class OutlinedBackButton extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BackButton(
      onPressed: () => Navigator.maybePop(context),
      style: IconButton.styleFrom(
        foregroundColor: Colors.grey[800],
        padding: const EdgeInsets.all(10),
        side: BorderSide(color: Colors.grey.shade400),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
