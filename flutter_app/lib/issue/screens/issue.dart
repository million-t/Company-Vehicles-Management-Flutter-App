import 'package:flutter/material.dart';
import '../models/issueModel.dart';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../repository/issue_repository.dart';
import '../../auth/repository/user_repository.dart';
import 'package:go_router/go_router.dart';
import 'createUpdateIssueDialog.dart';
import 'deleteReportDialog.dart';

class IssueScreen extends StatefulWidget {
  @override
  _IssueScreenState createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {
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
    IssueDialog dialog = IssueDialog();
    IssueDeleteDialog deleteDialog = IssueDeleteDialog();
    IssueRepository issueRepository = IssueRepository();
    return BlocProvider(
        create: (context) {
          return IssueBloc(
            issueRepository: issueRepository,
          );
        },
        child: Scaffold(
          backgroundColor: Color(0xff222831),
          appBar: AppBar(
            title: Text("Issues"),
            backgroundColor: const Color(0xff393E46),
          ),
          body: BlocBuilder<IssueBloc, IssueState>(
            builder: (_, state) {
              BlocProvider.of<IssueBloc>(_).add(IssueLoad());
              if (state is IssueOperationFailure) {
                return const Text('Could not Fetch!');
              }

              if (state is IssueOperationSuccess) {
                final issues = state.issues.toList();

                return ListView.builder(
                    itemCount: (issues != null) ? issues.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        key: Key(issues[index].id),
                        onDismissed: (direction) {
                          String strName = issues[index].content;
                          // helper!.deleteItem(items![index]);
                          setState(() {
                            // items!.removeAt(index);
                          });
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text("$strName deleted")));
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
                                  leading: CircleAvatar(
                                    radius: 15.0,
                                    backgroundColor:
                                        issues[index].status == 'pending'
                                            ? Colors.amberAccent
                                            : Colors.greenAccent,
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 9.0),
                                  title: Visibility(
                                      visible: userType == 'manager',
                                      child: Text(
                                        issues[index].driverName,
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 255, 255,
                                              255), // set the font color
                                          fontSize: 14.0, // set the font size
                                          // fontWeight:
                                          //     FontWeight.bold, // set the font weight
                                        ),
                                      )),
                                  subtitle: Text(issues[index].content,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 255, 255,
                                            255), // set the font color
                                        fontSize: 14.0, // set the font size
                                        // fontWeight:
                                        //     FontWeight.bold, // set the font weight
                                      )),
                                  onTap: () {
                                    showDialog(
                                        context: _,
                                        builder: (BuildContext _) =>
                                            dialog.buildAlert(
                                                context,
                                                issueRepository,
                                                issues[index],
                                                userType == 'driver',
                                                false));
                                  },
                                  trailing: PopupMenuButton(
                                    color: Colors.white,
                                    surfaceTintColor: Color(0xff393E46),
                                    onSelected: (value) {
                                      if (value == 'delete') {
                                        showDialog(
                                            context: _,
                                            builder: (BuildContext _) =>
                                                deleteDialog.buildDeleteAlert(
                                                    _,
                                                    issueRepository,
                                                    issues[index]));
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
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
          floatingActionButton: Visibility(
              visible: userType == 'driver',
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext _) => dialog.buildAlert(
                          context,
                          issueRepository,
                          Issue(content: ''),
                          userType == 'driver',
                          true));
                },
                child: Icon(Icons.add, color: Color(0xff222831)),
                backgroundColor: Color.fromARGB(255, 255, 211, 109),
              )),
        ));
  }
}
