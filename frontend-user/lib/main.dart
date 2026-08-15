import 'package:flutter/material.dart';
import 'package:frontend/feature/splashscreen/views/splashscreen.dart';
import 'package:flutter/services.dart';
import 'package:frontend/core/widgets/snackbar/internetsnackbar.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      // Add the builder here to wrap the app with the ConnectionListener:
      builder: (context, child) {
        return ConnectionListener(child: child ?? const SizedBox.shrink());
      },
      home: const SplashScreen(),
    );
  }
}
