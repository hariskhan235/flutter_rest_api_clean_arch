import 'package:flutter/material.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/auth/presentation/view/login_view.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/auth/user_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              isLoading = true;
              UserPreferences preferences = UserPreferences();
              await preferences.logout().then((value) {
                //print(value);
                if (value == true) {
                  isLoading = false;
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                }
              });
            },
            child: isLoading == true
                ? const CircularProgressIndicator()
                : const Text(
                    'LogOut',
                    style: TextStyle(color: Colors.white),
                  ),
          )
        ],
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
