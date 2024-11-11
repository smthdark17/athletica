import 'package:flutter/material.dart';
import 'auth_page.dart'; // Добавляем новый экран для авторизации

void main() {
  runApp(const AthleticaApp());
}

class AthleticaApp extends StatelessWidget {
  const AthleticaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Athletica App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Начинаем с экрана авторизации
      routes: {
        '/login': (context) => const AuthPage(), // Маршрут на страницу авторизации
        '/home': (context) => const HomeScreen(), // Главная страница после авторизации
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2; // Start with Profile Section

  static const List<Widget> _sections = <Widget>[
    ChatSection(),
    MapSection(),
    ProfileSection(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2d3d6b),
      body: Center(
        child: Container(
          width: 320,
          height: 600,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2d3d6b),
            borderRadius: BorderRadius.circular(20),
          ),
          child: _sections[_selectedIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Color(0xFFff7b3f)),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on, color: Color(0xFFff7b3f)),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color(0xFFff7b3f)),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          'ATHLETICA',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          child: Text(
            'ФОТО ПРОФИЛЯ',
            style: TextStyle(fontSize: 12, color: Color(0xFF333333)),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            children: [
              MenuOptionButton(title: 'редактировать инфо', onPressed: () {
                // Добавь переход или действие здесь
              }),
              MenuOptionButton(title: 'посмотреть подписки', onPressed: () {
                // Добавь переход или действие здесь
              }),
              MenuOptionButton(title: 'посмотреть историю игр', onPressed: () {
                // Добавь переход или действие здесь
              }),
              MenuOptionButton(title: 'посмотреть мои отзывы', onPressed: () {
                // Добавь переход или действие здесь
              }),
              MenuOptionButton(title: 'изменить пароль', onPressed: () {
                // Добавь переход или действие здесь
              }),
              MenuOptionButton(title: 'уведомления', onPressed: () {
                // Добавь переход или действие здесь
              }),
              MenuOptionButton(title: 'обратиться в техподдержку', onPressed: () {
                // Добавь переход или действие здесь
              }),
              MenuOptionButton(title: 'создать запрос на создание спота', onPressed: () {
                // Добавь переход или действие здесь
              }),
             MenuOptionButton(title: 'выйти из аккаунта', onPressed: () {
                // Добавь переход или действие здесь
              }),
            ],
          ),
        ),
      ],
    );
  }
}

class MenuOptionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const MenuOptionButton({required this.title, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class MapSection extends StatelessWidget {
  const MapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: const Text('Карта', style: TextStyle(color: Colors.black)),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          color: Colors.grey[300],
          child: Column(
            children: [
              const Text('СПОТ', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [Text('адрес'), Text('оценки')],
              ),
              const SizedBox(height: 10),
              const Text('СЛОТЫ', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text('18:00'),
                  Text('20:00'),
                  Text('создать свой слот'),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Действие при подписке
                },
                child: const Text('подписаться на спот'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChatSection extends StatelessWidget {
  const ChatSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'панель чатов',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
