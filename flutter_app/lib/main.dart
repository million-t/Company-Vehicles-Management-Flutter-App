import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'schedule/bloc_observer.dart';
import 'auth/blocs/blocs.dart';
import './auth/repository/user_repository.dart';
import './auth/screens/LoginPage.dart';
import 'routes.dart';

void main() {
  final UserRepository userRepository = UserRepository();

  // Bloc.observer = AppBlocObserver();
  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  MyApp({
    Key? key,
    required this.userRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final tokenObj = userRepository.getToken().then((value) => print(value));
    // userRepository.getUser();

    return BlocProvider(
        create: (BuildContext context) =>
            UserBloc(userRepository: userRepository),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: goRouter,
          title: 'VeValet',
        ));
  }
}
