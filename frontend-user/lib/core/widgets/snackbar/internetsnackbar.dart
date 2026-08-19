import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'snackbar.dart';
import 'package:frontend/core/network/connection.dart';

class ConnectionListener extends StatefulWidget {
  final Widget child;

  const ConnectionListener({super.key, required this.child});

  @override
  State<ConnectionListener> createState() => _ConnectionListenerState();
}

class _ConnectionListenerState extends State<ConnectionListener> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _wasOffline = false;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      _checkConnectionAndShowSnackBar();
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _checkConnectionAndShowSnackBar() async {
    final hasInternet = await hasRealInternetAccess();

    // Guard to ensure the widget is still mounted in the tree before using context
    if (!mounted) return;

    if (!hasInternet) {
      _wasOffline = true;

      // Call your customSnackbar for the error state
      customSnackbar(
        context,
        "No internet connection.",
        4000,
        true,
        SnackBarType.error,
      );
    } else if (hasInternet && _wasOffline) {
      _wasOffline = false;

      customSnackbar(context, "Back online!", 3000, true, SnackBarType.success);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
