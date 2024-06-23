import 'package:facultad/models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  // final String apiUrl = "http://127.0.0.1:8090/api/usuario/login";
  // final String apiUrl = "http://10.0.2.2:8090/api/usuario/login";http://10.0.2.2:8090/api
  final String apiUrl = '${dotenv.env['API_URL']}/login';

  Future<User?> login(String username, String password) async {
    print("enviado");
    print(username + password);
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    print("recibido");
    print(response.body);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      // if (body['token'] != null) {
      return User.fromJson(body);
      // }
    }
    return null;
  }
}
