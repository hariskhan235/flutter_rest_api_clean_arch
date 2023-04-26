import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/auth/authUtils/auth_utils.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/auth/models/user_model.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/auth/presentation/cubit/auth_states.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/auth/user_preferences.dart';
import 'package:http/http.dart' as http;

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(
          LoginInitial(),
        );
  dynamic jsonResponse;
  //final apiService = LoginApiService();
  final userPreferences = UserPreferences();
  var userToken;
  Future<dynamic> loginUser(
      String email, String password, BuildContext context) async {
    Map<String, dynamic> data = {'email': email, 'password': password};
    try {
      emit(LoginLoading());
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
          LoginSuccess(),
        );
      } else {
        emit(LoginFailure(message: response.statusCode.toString()));
        return Future.error(response.body);
      }
    } on HttpException catch (e) {
      emit(
        LoginFailure(message: e.toString()),
      );
      return Future.error(
        e.toString(),
      );
    } on SocketException catch (e) {
      emit(
        LoginFailure(message: e.toString()),
      );
      return Future.error(e.toString());
    } on TimeoutException catch (e) {
      emit(
        LoginFailure(message: e.toString()),
      );
      return Future.error(e.toString());
    } catch (e) {
      emit(LoginFailure(message: e.toString()));
      return Future.error(e);
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
