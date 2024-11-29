import 'package:flutter/material.dart';

/// Інформаційне діалогове вікно
void showInfoDialog(BuildContext context, String message,
    [VoidCallback? onDismiss]) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Information'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onDismiss != null) {
                onDismiss();
              }
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

/// Підтверджувальне діалогове вікно
void showConfirmDialog(
  BuildContext context,
  String message,
  VoidCallback onConfirm,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Confirmation'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: Text('Yes'),
          ),
        ],
      );
    },
  );
}
