import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/home/presenation/cubit/home_cubit.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/home/presenation/view/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit()..getUsers(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
