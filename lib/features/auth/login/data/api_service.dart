import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class LoginApiService {
  Future<dynamic> loginUser(var data, String url) async {
    dynamic jsonResponse;
    try {
      final response = await http.post(Uri.parse(url), body: data).timeout(
            const Duration(seconds: 10),
          );
      jsonResponse = returnResponse(response);
      print(jsonResponse);
    } on SocketException {
      throw Exception();
    } on TimeoutException {
      throw Exception();
    }
    return jsonResponse;
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
