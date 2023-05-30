import 'package:flutter/material.dart';
import '../models/schedule_model.dart';
// import 'reportDialogue.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../repository/schedule_repository.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    // ReportDialog dialog = ReportDialog();
    // ReportDeleteDialog deleteDialog = ScheduleDeleteDialog();
    ScheduleRepository scheduleRepository = ScheduleRepository();
    return BlocProvider(
        create: (context) {
          return ScheduleBloc(
            scheduleRepository: scheduleRepository,
          );
        },
        child: Scaffold(
          backgroundColor: Color(0xff222831),
          appBar: AppBar(
            title: Text("Schedules"),
            backgroundColor: const Color(0xff393E46),
          ),
          body: BlocBuilder<ScheduleBloc, ScheduleState>(
            buildWhen: (previousState, currentState) {
              return previousState is ScheduleLoading &&
                  currentState is! ScheduleLoading;
            },
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
                      return Dismissible(
                        key: Key(schedules[index].id),
                        onDismissed: (direction) {
                          String strName = schedules[index].driverName;
                          // helper!.deleteItem(items![index]);
                          setState(() {
                            // items!.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("$strName deleted")));
                        },
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(9.0, 5.6, 9.0, 1.4),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(4.0, 2.6, 4.0, 1.4),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.grey),
                                // set the border color
                                borderRadius: BorderRadius.circular(
                                    6.0), // set the border radius
                              ),
                              child: ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 16.0),
                                  title: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          9.0, 5.6, 9.0, 1.4),
                                      child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              4.0, 2.6, 4.0, 1.4),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.5, color: Colors.grey),
                                            // set the border color
                                            borderRadius: BorderRadius.circular(
                                                6.0), // set the border radius
                                          ),
                                          child: Column(children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              constraints: BoxConstraints(
                                                  maxWidth: 450.0,
                                                  minHeight: 50.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.memory(
                                                    base64Decode(
                                                        schedules[index]
                                                            .image
                                                            .split(',')
                                                            .last)),
                                              ),
                                            )
                                          ]))),
                                  subtitle: Text('Here: Driver and Duration',
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      )),
                                  onTap: () {},
                                  trailing: PopupMenuButton(
                                    color: Colors.white,
                                    surfaceTintColor: Color(0xff393E46),
                                    onSelected: (value) {
                                      ScheduleEvent event =
                                          ScheduleDelete(schedules[index].id);
                                      final scheduleBloc =
                                          BlocProvider.of<ScheduleBloc>(_);
                                      scheduleBloc.add(event);
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: 'delete',
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  )),
                            )),
                      );
                    });
              }

              return Center(child: const CircularProgressIndicator());
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.go('/schedule/create');
            },
            child: Icon(Icons.add, color: Color(0xff222831)),
            backgroundColor: Color.fromARGB(255, 255, 211, 109),
          ),
        ));
  }
}
