import 'package:flutter/material.dart';
import 'package:frontend/core/widgets/snackbar/snackbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("mama")),
      body: Center(
        child: Row(
          children: [
            FilledButton(
              onPressed: () {
                customSnackbar(
                  context,
                  "You click the button betch",
                  1200,
                  false,
                  SnackBarType.success,
                );
              },
              child: Text("Press me betch"),
            ),
          ],
        ),
      ),
    );
  }
}
