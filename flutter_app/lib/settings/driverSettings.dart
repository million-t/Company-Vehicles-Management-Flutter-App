import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../auth/repository/user_repository.dart';
import 'dart:convert';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String? userType;
  final userRepo = UserRepository();

  void getUserType() async {
    String? user = await userRepo.getUser();
    if (user != null) {
      final userJson = jsonDecode(user);
      setState(() {
        userType = userJson['type'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getUserType();
    return Scaffold(
      backgroundColor: Color(0xff222831),
      appBar: AppBar(
        backgroundColor: const Color(0xff393E46),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white, // Set the color of the app bar text
          ),
        ),
      ),
      body: Column(
        children: [
          Visibility(
              visible: userType == 'manager',
              child: Card(
                color: Colors.grey[300],
                child: ListTile(
                  title: const Text('Vehicles'),
                  onTap: () {
                    context.go('/settings/vehicles');
                  },
                ),
              )),
          Visibility(
              visible: userType == 'manager',
              child: Card(
                color: Colors.grey[300],
                child: ListTile(
                  title: const Text('Drivers'),
                  onTap: () {
                    context.go('/settings/drivers');
                  },
                ),
              )),
          Card(
            color: Colors.grey[300],
            child: ListTile(
              title: const Text('Profile'),
              onTap: () {
                context.go('/settings/profile');
              },
            ),
          ),
        ],
      ),
    );
  }
}
