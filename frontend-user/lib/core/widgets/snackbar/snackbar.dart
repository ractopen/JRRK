import 'package:flutter/material.dart';

enum SnackBarType { info, error, warning, success }

void customSnackbar(
  BuildContext context,
  String message,
  int durationMS,
  bool clear,
  SnackBarType type,
) {
  if (clear == true) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
  Color backgroundColor = Colors.blue;
  IconData icon = Icons.info_outline;
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  switch (type) {
    case SnackBarType.success:
      backgroundColor = Colors.green.shade700;
      icon = Icons.check_circle_outline;
      break;
    case SnackBarType.error:
      backgroundColor = Colors.red.shade700;
      icon = Icons.error_outline;
      break;
    case SnackBarType.warning:
      backgroundColor = Colors.orange.shade700;
      icon = Icons.warning_outlined;
      break;
    case SnackBarType.info:
      backgroundColor = isDarkMode
          ? Theme.of(context).colorScheme.surfaceContainerHighest
          : Theme.of(context).colorScheme.primaryContainer;
      icon = Icons.info_outline;
      break;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: durationMS),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          //if you want to be able to do a thing
        },
      ),
    ),
  );
}
