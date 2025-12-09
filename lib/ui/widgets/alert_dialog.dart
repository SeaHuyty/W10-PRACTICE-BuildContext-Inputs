import 'package:flutter/material.dart';

class InputAlertDialog extends StatelessWidget {
  const InputAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('The title cannot be empty'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Okay'),
              child: const Text('Okay'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}