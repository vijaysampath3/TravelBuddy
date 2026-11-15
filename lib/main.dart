import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/buddy_registration_data.dart';
import 'screens/screen0_onboarding.dart';
import 'screens/screen1_login.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const TravelBuddyApp());
}

class TravelBuddyApp extends StatefulWidget {
  const TravelBuddyApp({super.key});

  @override
  State<TravelBuddyApp> createState() => _TravelBuddyAppState();
}

class _TravelBuddyAppState extends State<TravelBuddyApp> {
  final BuddyRegistrationData _registrationData = BuddyRegistrationData();

  @override
  Widget build(BuildContext context) {
    return RegistrationScope(
      data: _registrationData,
      child: MaterialApp(
        title: 'Travel Buddy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppTheme.creamBg,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppTheme.primaryOrange,
            primary: AppTheme.primaryOrange,
            surface: AppTheme.creamBg,
          ),
          fontFamily: 'PlusJakartaSans',
        ),
        home: const OnboardingScreen(),
      ),
    );
  }
}
