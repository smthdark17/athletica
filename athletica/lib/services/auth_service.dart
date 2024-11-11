import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://localhost:8000/api';  // URL для API

  // Метод для регистрации пользователя
  Future<String?> registerUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 201) {
        return 'User registered successfully';
      } else {
        print('Failed to register user: ${response.body}');
        return null;
      }
    } catch (error) {
      print('Error registering user: $error');
      return null;
    }
  }

  // Метод для логина пользователя
  Future<String?> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('User logged in with token: ${data['token']}');
        return data['token'];  // Возвращаем токен при успешном входе
      } else {
        print('Failed to login: ${response.body}');
        return null;
      }
    } catch (error) {
      print('Error logging in: $error');
      return null;
    }
  }
}
