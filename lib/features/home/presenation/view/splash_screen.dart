import 'package:flutter/material.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/auth/login/presentation/view/login_view.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/auth/login/user_preferences.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/home/presenation/view/home_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserPreferences userPreferences = UserPreferences();
  @override
  void initState() {
    userPreferences.getUser().then((value) {
      if (value.token.isEmpty || value.token == 'null') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginView()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomeView()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
