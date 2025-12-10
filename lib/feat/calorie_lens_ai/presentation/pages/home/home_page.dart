import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String id = 'home_page';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome to Calorie Lens AI Home Page!'),
      ),
    );
  }
}
