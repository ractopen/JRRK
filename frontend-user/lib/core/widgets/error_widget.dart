// import 'package:flutter/material.dart';

// class AppErrorWidget extends StatelessWidget {
//   final String message;
//   final VoidCallback onRetry;

//   const AppErrorWidget({
//     super.key,
//     required this.message,
//     required this.onRetry,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.error_outline_rounded,
//               size: 64,
//               color: theme.colorScheme.error,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Something went wrong',
//               style: theme.textTheme.titleMedium?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               message,
//               textAlign: TextAlign.center,
//               style: theme.textTheme.bodyMedium?.copyWith(
//                 color: theme.colorScheme.onSurfaceVariant,
//               ),
//             ),
//             const SizedBox(height: 24),
//             FilledButton.tonalIcon(
//               onPressed: onRetry,
//               icon: const Icon(Icons.refresh_rounded),
//               label: const Text('Try Again'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Reusable static helper to trigger a Material 3 compliant error SnackBar
//   static void showSnackBar(BuildContext context, String message) {
//     final theme = Theme.of(context);
    
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: theme.colorScheme.error,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         content: Row(
//           children: [
//             Icon(
//               Icons.error_outline_rounded,
//               color: theme.colorScheme.onError,
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 message,
//                 style: TextStyle(
//                   color: theme.colorScheme.onError,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         action: SnackBarAction(
//           label: 'Dismiss',
//           textColor: theme.colorScheme.onError,
//           onPressed: () {
//             ScaffoldMessenger.of(context).hideCurrentSnackBar();
//           },
//         ),
//       ),
//     );
//   }
// }
