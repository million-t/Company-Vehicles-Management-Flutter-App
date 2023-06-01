import 'package:flutter/material.dart';
import '../models/report_model.dart';
import 'reportDialogue.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../repository/report_repository.dart';
import 'package:go_router/go_router.dart';
import 'deleteReportDialog.dart';
import '../../auth/repository/user_repository.dart';
import 'dart:convert';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
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

    ReportDialog dialog = ReportDialog();
    ReportDeleteDialog deleteDialog = ReportDeleteDialog();
    ReportRepository reportRepository = ReportRepository();
    return BlocProvider(
        create: (context) {
          return ReportBloc(
            reportRepository: reportRepository,
          );
        },
        child: Scaffold(
            backgroundColor: Color(0xff222831),
            appBar: AppBar(
              title: const Text("Reports"),
              backgroundColor: const Color(0xff393E46),
            ),
            body: BlocBuilder<ReportBloc, ReportState>(
              // buildWhen: (previousState, currentState) {
              //   return previousState is ReportLoading &&
              //       currentState is! ReportLoading;
              // },
              builder: (_, state) {
                BlocProvider.of<ReportBloc>(_).add(ReportLoad());
                if (state is ReportOperationFailure) {
                  return const Text('Could not Fetch!');
                }

                if (state is ReportOperationSuccess) {
                  final reports = state.reports.toList();

                  return ListView.builder(
                      itemCount: (reports != null) ? reports.length : 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
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
                                  title: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 8.0),
                                      child: Text(
                                        reports[index].vehicleName,
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 255, 255,
                                              255), // set the font color
                                          fontSize: 14.0, // set the font size
                                          // fontWeight:
                                          //     FontWeight.bold, // set the font weight
                                        ),
                                      )),
                                  subtitle: Row(children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Visibility(
                                              visible: userType == 'manager',
                                              child: const Text('Driver Name',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Color.fromRGBO(
                                                        66, 108, 134, 1),
                                                  ))),
                                          const SizedBox(
                                            height: 7.0,
                                          ),
                                          const Text('Price',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Color.fromRGBO(
                                                    66, 108, 134, 1),
                                              )),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          const Text('Distance',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Color.fromRGBO(
                                                    66, 108, 134, 1),
                                              )),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          const Text('Litres',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Color.fromRGBO(
                                                    66, 108, 134, 1),
                                              ))
                                        ]),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Visibility(
                                              visible: userType == 'manager',
                                              child: Text(
                                                  reports[index].driverName,
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                  ))),
                                          const SizedBox(
                                            height: 7.0,
                                          ),
                                          Text("\$ ${reports[index].price}",
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                              )),
                                          const SizedBox(
                                            height: 7.0,
                                          ),
                                          Text("${reports[index].distance} km",
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                              )),
                                          const SizedBox(
                                            height: 7.0,
                                          ),
                                          Text(reports[index].litres,
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ))
                                        ])
                                  ]),
                                  onTap: () {},
                                  trailing: PopupMenuButton(
                                    color: Colors.white,
                                    surfaceTintColor: Color(0xff393E46),
                                    onSelected: (value) {
                                      if (value == 'update') {
                                        showDialog(
                                            context: _,
                                            builder: (BuildContext _) =>
                                                dialog.buildAlert(
                                                    _,
                                                    reportRepository,
                                                    reports[index],
                                                    false));
                                      } else if (value == 'delete') {
                                        showDialog(
                                            context: _,
                                            builder: (BuildContext _) =>
                                                deleteDialog.buildDeleteAlert(
                                                    _,
                                                    reportRepository,
                                                    reports[index]));
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        value: 'update',
                                        child: Text('Edit'),
                                      ),
                                      const PopupMenuItem(
                                        value: 'delete',
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  )),
                            ));
                      });
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
            floatingActionButton: Visibility(
              visible: userType == 'driver',
              child: FloatingActionButton(
                onPressed: () {
                  context.go('/report/details');
                },
                backgroundColor: const Color.fromARGB(255, 255, 211, 109),
                child: const Icon(Icons.add, color: Color(0xff222831)),
              ),
            )));
  }
}
