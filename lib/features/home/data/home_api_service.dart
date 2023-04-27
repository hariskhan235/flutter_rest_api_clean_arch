import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeApiService {
  //List<Users> users = [];
  Future<dynamic> getUsers() async {
    try {
      var data;
      final response = await http.get(
          Uri.parse('https://reqres.in/api/users?page=2'),
          headers: <String, String>{'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
      return data;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
