import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jrrk/main.dart';

void main() {
  testWidgets('EcoScan+ onboarding flow reaches dashboard', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const EcoScanApp());

    expect(find.text('EcoScan+'), findsWidgets);
    expect(find.text('Create an account'), findsOneWidget);

    await tester.enterText(
      find.byType(TextFormField).first,
      'user@example.com',
    );
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    final otpFields = find.byType(TextFormField);
    expect(otpFields, findsNWidgets(6));

    for (var i = 0; i < 6; i++) {
      await tester.enterText(otpFields.at(i), (i + 1).toString());
    }
    await tester.tap(find.text('Verify'));
    await tester.pumpAndSettle();

    expect(find.text('Setup Password for the account'), findsOneWidget);

    final passwordFields = find.byType(TextFormField);
    await tester.enterText(passwordFields.at(0), 'Password123');
    await tester.enterText(passwordFields.at(1), 'Password123');
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Recent Overview'), findsOneWidget);
    expect(find.text('Welcome back, Explorer! 👋'), findsOneWidget);
  });
}
