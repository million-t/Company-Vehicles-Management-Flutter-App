import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/auth/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/userModel.dart';
import '../../Route/appRoute.dart';
import '../../Route/appRouteConstants.dart';
import '../blocs/user_bloc.dart';
import '../blocs/user_event.dart';
import '../repository/user_repository.dart';
import '../data_providers/remote_user_data_provider.dart';

class LoginPage extends StatefulWidget {
  UserRepository userRepository;
  LoginPage({required this.userRepository});
  @override
  _LoginPageState createState() =>
      _LoginPageState(userRepository: userRepository);
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _managerIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLogin = true;
  UserRepository userRepository;

  final List<String> userTypes = ["driver", "manager"];
  String _userType = 'driver';
  _LoginPageState({required this.userRepository});
  @override
  Widget build(BuildContext context) {
    String buttonText = _isLogin ? 'Login' : 'Sign up';
    String buttonText2 = !_isLogin ? 'Login' : 'Sign up';
    userRepository.getToken().then((value) {
      print("-<>- $value");
      if (value.toString() != 'null') {
        context.go('/schedule');
      }
    });

    return BlocProvider(
        create: (context) {
          return UserBloc(
            userRepository: userRepository,
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Welcome'),
            backgroundColor: Color.fromARGB(255, 223, 25, 25),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50.0),
                  Visibility(
                      visible: !_isLogin,
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                      )),
                  SizedBox(height: 16.0),
                  TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      )),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 16.0),
                  Visibility(
                      visible: (!_isLogin) && _userType == "driver",
                      child: TextField(
                        controller: _managerIdController,
                        decoration: const InputDecoration(
                          labelText: 'Manager ID',
                        ),
                      )),
                  SizedBox(height: 16.0),
                  Visibility(
                      visible: !_isLogin,
                      child: DropdownButton(
                        items: userTypes.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _userType = value.toString();
                          });
                        },
                        value: _userType,
                      )),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      User user;
                      String password;
                      String email;

                      UserEvent event;
                      if (!_isLogin) {
                        email = _emailController.text;
                        password = _passwordController.text;
                        String name = _nameController.text;

                        String type = _userType;
                        String managerId = _managerIdController.text;

                        user = User(
                            name: name,
                            email: email,
                            password: password,
                            type: type,
                            managerId: managerId);

                        event = UserSignup(user);
                      } else {
                        email = _emailController.text;
                        password = _passwordController.text;

                        event = UserLogin(email, password);
                      }

                      BlocProvider.of<UserBloc>(context).add(event);

                      context.go('/schedule');
                    },
                    child: Text(buttonText),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to the signup page
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(buttonText2),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
