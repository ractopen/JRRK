import 'package:flutter/material.dart';

class EcoScanTheme {
  static const Color peach = Color(0xFFF9CBB0);
  static const Color cream = Color(0xFFFCEEE4);
  static const Color mistTeal = Color(0xFFA2C6CE);
  static const Color forestPine = Color(0xFF38616B);
  static const Color slateWhite = Color(0xFFF9FAFB);
  static const Color charcoal = Color(0xFF111111);
  static const Color slate = Color(0xFF5F6771);
  static const Color border = Color(0xFFE5E7EB);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: slateWhite,
      colorScheme: ColorScheme.fromSeed(
        seedColor: forestPine,
        primary: forestPine,
        secondary: mistTeal,
        surface: Colors.white,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w900,
          color: charcoal,
          letterSpacing: -0.7,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: charcoal,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: forestPine, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        hintStyle: const TextStyle(color: Color(0xFF8A8F96), fontSize: 15),
      ),
    );
  }
}

void showPlaceholderDialog(BuildContext context, String feature) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Feature Placeholder'),
      content: Text('$feature is ready for future product integration and design handoff.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

void logoutAndReturnToLogin(BuildContext context) {
  Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
}

class EcoBackground extends StatelessWidget {
  const EcoBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              EcoScanTheme.peach,
              EcoScanTheme.cream,
              EcoScanTheme.mistTeal,
              EcoScanTheme.forestPine,
            ],
            stops: [0.0, 0.35, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
