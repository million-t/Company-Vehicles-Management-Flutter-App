import 'package:flutter/material.dart';
import '../auth/models/userModel.dart';
// import 'reportDialogue.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth/blocs/blocs.dart';
import '../auth/repository/user_repository.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
// import 'vehicleDeleteDialog.dart';
// import 'vehicleUpdateDialog.dart';

class DriversScreen extends StatefulWidget {
  @override
  _DriversScreenState createState() => _DriversScreenState();
}

class _DriversScreenState extends State<DriversScreen> {
  // VehicleDeleteDialog deleteDialog = VehicleDeleteDialog();

  @override
  Widget build(BuildContext context) {
    // VehicleUpdateDialog updateDialog = VehicleUpdateDialog();
    UserRepository vehicleRepository = UserRepository();
    return BlocProvider(
        create: (context) {
          return UserBloc(
            userRepository: vehicleRepository,
          );
        },
        child: Scaffold(
          backgroundColor: Color(0xff222831),
          appBar: AppBar(
            title: Text("Drivers"),
            backgroundColor: const Color(0xff393E46),
          ),
          body: BlocBuilder<UserBloc, UserState>(
            buildWhen: (previous, current) => previous is UserLoading,
            builder: (context, state) {
              BlocProvider.of<UserBloc>(context).add(UserLoad());
              if (state is UserOperationFailure) {
                return const Center(child: Text('Could not Fetch!'));
              }

              if (state is UserOperationSuccess) {
                final drivers = state.users.toList();

                return ListView.builder(
                    itemCount: (drivers != null) ? drivers.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                          key: Key(drivers[index].id!),
                          onDismissed: (direction) {
                            String strName = drivers[index].name;

                            setState(() {});
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(content: Text("$strName deleted")));
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(9.0, 5.6, 9.0, 1.4),
                            child: Container(
                                padding:
                                    EdgeInsets.fromLTRB(4.0, 2.6, 4.0, 1.4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey),
                                  // set the border color
                                  borderRadius: BorderRadius.circular(
                                      6.0), // set the border radius
                                ),
                                child: ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 16.0),
                                  title: Text(
                                    drivers[index].name,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255,
                                          255), // set the font color
                                      fontSize: 22.0, // set the font size
                                    ),
                                  ),
                                  subtitle: Text(drivers[index].email,
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      )),
                                  onTap: () {},
                                )),
                          ));
                    });
              }

              return Center(child: const CircularProgressIndicator());
            },
          ),
        ));
  }
}
