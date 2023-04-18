import 'package:flutter_rest_api_bloc_clean_arch/features/auth/login/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(UserModel model) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', model.token);
    return true;
  }

  Future<UserModel> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    return UserModel(token: token!);
  }
}
