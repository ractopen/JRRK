import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jrrk/main.dart';

void main() {
  testWidgets('user sign in redirects to the user dashboard', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const EcoScanApp());

    expect(find.text('EcoScan+'), findsWidgets);
    expect(find.text('Welcome Back'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'user@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Welcome back, user@example.com'), findsOneWidget);
  });

  testWidgets('register flow reaches password setup after OTP verification', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const EcoScanApp());

    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'newuser@example.com');
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Enter 6-Digit Code'), findsOneWidget);

    for (var index = 0; index < 6; index++) {
      await tester.enterText(find.byType(TextFormField).at(index), '${index + 1}');
    }
    await tester.tap(find.text('Verify'));
    await tester.pumpAndSettle();

    expect(find.text('Create Password'), findsOneWidget);
  });
}
