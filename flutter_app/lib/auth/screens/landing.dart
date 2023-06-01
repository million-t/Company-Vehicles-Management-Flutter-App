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
    return const Scaffold(
      backgroundColor: Color(0xff222831),
      body: SafeArea(
        child: Center(
          child: Text(
            'VeValet',
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
