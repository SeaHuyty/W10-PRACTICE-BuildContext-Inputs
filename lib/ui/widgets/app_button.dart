import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  const AppButton({super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(20),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(label, style: TextStyle(fontSize: 20)),
    );
  }
}