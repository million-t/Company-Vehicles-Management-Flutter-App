import 'package:flutter/material.dart';
import '../../auth/repository/user_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../repository/schedule_repository.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ScheduleScreenState createState() => ScheduleScreenState();
}

class ScheduleScreenState extends State<ScheduleScreen> {
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
    ScheduleRepository scheduleRepository = ScheduleRepository();
    return BlocProvider(
        create: (context) {
          return ScheduleBloc(
            scheduleRepository: scheduleRepository,
          );
        },
        child: Scaffold(
            backgroundColor: const Color(0xff222831),
            appBar: AppBar(
              title: const Text("Schedules"),
              backgroundColor: const Color(0xff393E46),
            ),
            body: BlocBuilder<ScheduleBloc, ScheduleState>(
              // buildWhen: (previousState, currentState) {
              //   return previousState is ScheduleLoading &&
              //       currentState is! ScheduleLoading;
              // },
              builder: (_, state) {
                BlocProvider.of<ScheduleBloc>(_).add(ScheduleLoad());
                if (state is ScheduleOperationFailure) {
                  return const Center(child: Text('Could not Fetch!'));
                }

                if (state is ScheduleOperationSuccess) {
                  final schedules = state.schedules.toList();

                  return ListView.builder(
                      itemCount: (schedules != null) ? schedules.length : 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(9.0, 10.0, 9.0, 5.4),
                          child: Container(
                            // padding: EdgeInsets.fromLTRB(4.0, 2.6, 4.0, 1.4),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              // set the border color
                              borderRadius: BorderRadius.circular(
                                  8), // set the border radius
                            ),
                            child: Column(children: [
                              Column(children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  width: MediaQuery.of(context).size.width,
                                  constraints: const BoxConstraints(
                                      maxWidth: 450.0, minHeight: 50.0),
                                  child: ClipRRect(
                                      // borderRadius: BorderRadius.circular(8),
                                      child: Container()
                                      // Image.memory(base64Decode(
                                      //     schedules[index]
                                      //         .image
                                      //         .split(',')
                                      //         .last)),
                                      ),
                                ),
                              ]),
                              ListTile(
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      8.0, 16.0, 6.0, 4.0),
                                  subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "License Plate Number : ${schedules[index].licensePlateNumber}",
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                            )),
                                        const SizedBox(height: 8.0),
                                        Text(
                                            "${schedules[index].start.split('T').first}   -   ${schedules[index].end.split('T').first}",
                                            style: const TextStyle(
                                              fontSize: 8.0,
                                              color: Color.fromARGB(
                                                  255, 233, 231, 231),
                                            ))
                                      ]),
                                  onTap: () {},
                                  trailing: Visibility(
                                      visible: userType == 'manager',
                                      child: PopupMenuButton(
                                        color: Colors.white,
                                        surfaceTintColor: Color(0xff393E46),
                                        onSelected: (value) {
                                          ScheduleEvent event = ScheduleDelete(
                                              schedules[index].id);
                                          final scheduleBloc =
                                              BlocProvider.of<ScheduleBloc>(_);
                                          scheduleBloc.add(event);
                                        },
                                        itemBuilder: (context) => [
                                          const PopupMenuItem(
                                            value: 'delete',
                                            child: Text('Delete'),
                                          ),
                                        ],
                                      )))
                            ]),
                          ),
                        );
                      });
                }

                return Center(child: const CircularProgressIndicator());
              },
            ),
            floatingActionButton: Visibility(
              visible: userType == 'manager',
              child: FloatingActionButton(
                onPressed: () {
                  context.go('/schedule/create');
                },
                backgroundColor: const Color.fromARGB(255, 255, 211, 109),
                child: const Icon(Icons.add, color: Color(0xff222831)),
              ),
            )));
  }
}
