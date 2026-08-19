import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';

Future<bool> hasNetworkConnection() async {
  final List<ConnectivityResult> results = await Connectivity()
      .checkConnectivity();

  if (results.isEmpty || results.contains(ConnectivityResult.none)) {
    return false;
  }
  return true;
}

Future<bool> hasRealInternetAccess() async {
  final List<ConnectivityResult> results = await Connectivity()
      .checkConnectivity();
  if (results.isEmpty || results.contains(ConnectivityResult.none)) {
    return false;
  }

  try {
    final result = await InternetAddress.lookup(
      'google.com',
    ).timeout(const Duration(seconds: 3));
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}
