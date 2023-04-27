import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/auth/presentation/view/login_view.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/auth/user_preferences.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/home/presenation/cubit/home_cubit.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/home/presenation/cubit/home_states.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
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
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeSuccess) {
            Fluttertoast.showToast(msg: 'Data Loaded');
          } else if (state is HomeFailure) {
            Fluttertoast.showToast(msg: state.message);
          } else {
            Fluttertoast.showToast(msg: 'Loading');
          }
        },
        builder: (context, state) {
          if (state is HomeSuccess) {
            final data = state.data?['data'];
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    title: Text(
                      data[index]['first_name'],
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        data[index]['avatar'].toString(),
                      ),
                    ),
                    subtitle: Text(
                      data[index]['email'],
                    ),
                    trailing: Text(
                      data[index]['id'].toString(),
                    ),
                  ),
                );
              },
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Shimmer(
                  direction: ShimmerDirection.btt,
                  gradient: const LinearGradient(
                    colors: [],
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 10,
                    decoration: const BoxDecoration(color: Colors.black38),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
