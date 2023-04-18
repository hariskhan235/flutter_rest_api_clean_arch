import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/auth/authUtils/auth_utils.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/auth/login/data/api_service.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/auth/login/models/login_model.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/auth/login/presentation/cubit/login_states.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/auth/login/user_preferences.dart';
import 'package:http/http.dart' as http;

class LoginCubit extends Cubit<LoginUserStates> {
  LoginCubit()
      : super(
          LoginInitialState(),
        );
  dynamic jsonResponse;
  //final apiService = LoginApiService();
  final userPreferences = UserPreferences();
  var userToken;
  Future<dynamic> loginUser(
      String email, String password, BuildContext context) async {
    Map<String, dynamic> data = {'email': email, 'password': password};
    try {
      final response =
          await http.post(Uri.parse(AuthUtils.loginUrl), body: data);

      if (response.statusCode == 200) {
        userToken = jsonDecode(response.body);
        userPreferences
            .saveUser(UserModel.fromJson(userToken))
            .onError((error, stackTrace) {
          return Future.error(error.toString());
        });
        emit(
          LoggedInState(response),
        );
      } else {
        emit(LoginErrorState(response.statusCode.toString()));
        return Future.error(response.body);
      }
    } on HttpException catch (e) {
      emit(
        LoginErrorState(e.message),
      );
      return Future.error(
        e.toString(),
      );
    } on SocketException catch (e) {
      emit(LoginErrorState(e.message.toString()));
      return Future.error(e.toString());
    } on TimeoutException catch (e) {
      emit(LoginErrorState(e.message.toString()));
      return Future.error(e.toString());
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      default:
        throw Exception('An Error Occured');
    }
  }
}
