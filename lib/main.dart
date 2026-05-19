import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/onboarding_screen.dart';
import 'screens/goal_setup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/scan_result_screen.dart';
import 'screens/food_scan_screen.dart';
import 'screens/diary_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/streak_badges_screen.dart';

void main() {
  runApp(const SnapMacroApp());
}

class SnapMacroApp extends StatelessWidget {
  const SnapMacroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnapMacro AI',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/goal-setup': (context) => const GoalSetupScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/scan-result': (context) => const ScanResultScreen(),
        '/food-scan': (context) => const FoodScanScreen(),
        '/diary': (context) => const DiaryScreen(),
        '/analytics': (context) => const AnalyticsScreen(),
        '/streak-badges': (context) => const StreakBadgesScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
