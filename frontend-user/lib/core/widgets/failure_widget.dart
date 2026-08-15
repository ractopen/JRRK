// import 'package:flutter/material.dart';

// class FailureSnackBar extends SnackBar {
//   FailureSnackBar({
//     super.key,
//     required String message,
//     required BuildContext context,
//     VoidCallback? onDismiss,
//   }) : super(
//           behavior: SnackBarBehavior.floating,
//           backgroundColor: Theme.of(context).colorScheme.error,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           content: Row(
//             children: [
//               Icon(
//                 Icons.error_outline_rounded,
//                 color: Theme.of(context).colorScheme.onError,
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Text(
//                   message,
//                   style: TextStyle(
//                     color: Theme.of(context).colorScheme.onError,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           action: SnackBarAction(
//             label: 'Dismiss',
//             textColor: Theme.of(context).colorScheme.onError,
//             onPressed: onDismiss ?? () {
//               ScaffoldMessenger.of(context).hideCurrentSnackBar();
//             },
//           ),
//         );
// }
