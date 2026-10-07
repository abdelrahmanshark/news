import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news/main.dart';
import 'package:news/providers/app_providers.dart';
import 'package:news/utils/app_animations.dart';

void main() {
  testWidgets('Splash opens the home screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const AppProviders(
        initialThemeMode: ThemeMode.light,
        initialLocale: Locale('en'),
        initialCountryCode: null,
        child: NewsApp(),
      ),
    );
    // Image decoding runs on real async, so let the logo precache finish first.
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 100)),
    );
    await tester.pumpAndSettle();
    await tester.pump(AppAnimations.splashHold);
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
  });
}
