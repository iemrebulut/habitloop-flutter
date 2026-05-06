import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'features/habits/providers/habit_provider.dart';
import 'features/onboarding/screens/onboarding_screen.dart';

/// Kök widget. Global [HabitProvider] ile aydınlık/karanlık tema çiftini
/// bağlar; ardından giriş rotası olarak [OnboardingScreen]'i gösterir.
class HabitLoopApp extends StatelessWidget {
  const HabitLoopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HabitProvider>(
      create: (_) => HabitProvider(),
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.system,
        locale: const Locale('tr', 'TR'),
        supportedLocales: const <Locale>[Locale('tr', 'TR')],
        localizationsDelegates: const <LocalizationsDelegate<Object>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const OnboardingScreen(),
      ),
    );
  }
}
