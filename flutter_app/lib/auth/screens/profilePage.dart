import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/auth/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/userModel.dart';
// import '../../Route/appRoute.dart';
// import '../../Route/appRouteConstants.dart';
import '../blocs/user_bloc.dart';
import '../blocs/user_event.dart';
import '../repository/user_repository.dart';
import 'dart:convert';
import '../data_providers/remote_user_data_provider.dart';

class ProfilePage extends StatefulWidget {
  UserRepository userRepository = UserRepository();

  @override
  _ProfilePageState createState() =>
      _ProfilePageState(userRepository: userRepository);
}

class _ProfilePageState extends State<ProfilePage> {
  UserRepository userRepository;
  _ProfilePageState({required this.userRepository});

  // String? userType;

  // void getUserType() async {
  //   String? user = await userRepository.getUser();
  //   if (user != null) {
  //     final userJson = jsonDecode(user);
  //     setState(() {
  //       userType = userJson['type'];
  //       _emailController = userJson['email'];
  //       _nameController = userJson['name'];
  //       // _managerIdController = "userJson['manager_id']";
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // getUserType();
    return BlocProvider(
        create: (context) {
          return UserBloc(
            userRepository: userRepository,
          );
        },
        child: Scaffold(
          // appBar: AppBar(
          //   // title: Text('Welcome'),
          //   backgroundColor: Color.fromARGB(255, 223, 25, 25),
          // ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50.0),
                  // Visibility(
                  //     visible: true,
                  //     child: TextField(
                  //       controller: _nameController,
                  //       decoration: InputDecoration(
                  //         labelText: 'Name',
                  //       ),
                  //     )),
                  // SizedBox(height: 16.0),
                  // TextField(
                  //     controller: _emailController,
                  //     decoration: const InputDecoration(
                  //       labelText: 'Email',
                  //     )),
                  // SizedBox(height: 16.0),
                  // TextField(
                  //   controller: _passwordController,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Password',
                  //   ),
                  //   obscureText: true,
                  // ),
                  // SizedBox(height: 16.0),
                  // Visibility(
                  //     visible: userType == "driver",
                  //     child: TextField(
                  //       controller: _managerIdController,
                  //       decoration: const InputDecoration(
                  //         labelText: 'Manager ID',
                  //       ),
                  //     )),
                  // SizedBox(height: 16.0),
                  // SizedBox(height: 24.0),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     User user;
                  //     String password;
                  //     String email;

                  //     UserEvent event;

                  //     email = _emailController.text;
                  //     password = _passwordController.text;
                  //     String name = _nameController.text;

                  //     String type = userType!;
                  //     String managerId = _managerIdController.text;

                  //     user = User(
                  //         name: name,
                  //         email: email,
                  //         password: password,
                  //         type: type,
                  //         managerId: managerId);

                  //     event = UserUpdate(user);

                  //     BlocProvider.of<UserBloc>(context).add(event);

                  //     // context.go('/schedule');
                  //   },
                  //   child: Text('Update'),
                  // ),
                  TextButton(
                    onPressed: () async {
                      await userRepository.logout();
                      context.go('/login');
                    },
                    child: Text("Logout"),
                  ),
                  TextButton(
                    onPressed: () {
                      // setState(() {
                      //   _isLogin = !_isLogin;
                      // });
                    },
                    child: Text("Delete Account"),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
