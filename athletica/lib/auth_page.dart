import 'package:flutter/material.dart';
import '/services/auth_service.dart';  // Импортируем сервис аутентификации

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController = TextEditingController();
  final TextEditingController _registerEmailController = TextEditingController();
  final TextEditingController _registerPasswordController = TextEditingController();
  final TextEditingController _registerConfirmPasswordController = TextEditingController();

  bool isLogin = true;
  String errorMessage = '';

  final AuthService _authService = AuthService(); // Создаем объект AuthService

  // Функция для переключения между формами
  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
      errorMessage = '';
    });
  }

  // Функция для входа
  Future<void> loginUser() async {
    final email = _loginEmailController.text;
    final password = _loginPasswordController.text;

    final result = await _authService.loginUser(email, password);

    if (result != null) {
      // Если логин успешен, перенаправляем на домашнюю страницу
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        errorMessage = 'Ошибка входа';
      });
    }
  }

  // Функция для регистрации
  Future<void> registerUser() async {
    if (_registerPasswordController.text != _registerConfirmPasswordController.text) {
      setState(() {
        errorMessage = 'Пароли не совпадают';
      });
      return;
    }

    final email = _registerEmailController.text;
    final password = _registerPasswordController.text;

    final result = await _authService.registerUser(email, password);

    if (result != null) {
      setState(() {
        isLogin = true;
        errorMessage = 'Регистрация успешна';
      });
    } else {
      setState(() {
        errorMessage = 'Ошибка регистрации';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2a3a5e),
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ATHLETICA BASKETBALL',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
              if (isLogin)
                Column(
                  children: [
                    TextField(
                      controller: _loginEmailController,
                      decoration: InputDecoration(
                        hintText: 'Номер телефона или Email',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _loginPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Пароль',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: loginUser,
                      child: Text('ВОЙТИ'),
                    ),
                    TextButton(
                      onPressed: toggleForm,
                      child: Text('нет аккаунта? РЕГИСТРАЦИЯ', style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    TextField(
                      controller: _registerEmailController,
                      decoration: InputDecoration(
                        hintText: 'Номер телефона или Email',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _registerPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Пароль',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _registerConfirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Повторить пароль',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: registerUser,
                      child: Text('ЗАРЕГИСТРИРОВАТЬСЯ'),
                    ),
                    TextButton(
                      onPressed: toggleForm,
                      child: Text('Уже есть аккаунт? ВОЙТИ', style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
