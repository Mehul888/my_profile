import 'package:flutter/material.dart';

class ConfirmationPopup extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;

  ConfirmationPopup({required this.title, required this.message, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Logout'),
          onPressed: onConfirm,
        ),
      ],
    );
  }
}

class EditConfirmationPopup extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;

  EditConfirmationPopup({required this.title, required this.message, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          child: Text(
            'Okay',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Discard changes'),
          onPressed: onConfirm,
        ),
      ],
    );
  }
}
