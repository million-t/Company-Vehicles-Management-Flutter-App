import 'package:flutter/material.dart';
import '../repository/user_repository.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  UserRepository userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    userRepository.getToken().then((value) {
      if (value.toString() != 'null') {
        context.go('/schedule');
      } else {
        context.go('/login');
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Text(
            'Welcome!',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
