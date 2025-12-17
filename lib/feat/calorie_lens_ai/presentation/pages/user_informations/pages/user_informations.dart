import 'package:flutter/material.dart';

class UserInformations extends StatelessWidget {
  const UserInformations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'User Informations Screen',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
