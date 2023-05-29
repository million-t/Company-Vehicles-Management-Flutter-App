import 'package:flutter/material.dart';
import '../models/issueModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/issue_repository.dart';
import '../blocs/blocs.dart';
import 'package:go_router/go_router.dart';

class IssueDeleteDialog {
  Widget buildDeleteAlert(
      BuildContext context, IssueRepository issueRepository, Issue issue) {
    return AlertDialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Color(0xff393E46),
        title: const Text(
          'Delete Report?',
          style: TextStyle(color: Colors.white),
        ),
        content: BlocProvider(create: (context) {
          return IssueBloc(
            issueRepository: issueRepository,
          );
        }, child: SingleChildScrollView(
          child: BlocBuilder<IssueBloc, IssueState>(builder: (_, state) {
            return Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Color.fromARGB(255, 255, 236, 192))),
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Color(0xff222831)),
                      ),
                      onPressed: () {
                        IssueEvent event = IssueDelete(issue.id);
                        final reportBloc = BlocProvider.of<IssueBloc>(_);
                        reportBloc.add(event);
                        context.pop();
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  const Color.fromARGB(255, 255, 211, 109))),
                      child: const Text(
                        'No',
                        style: TextStyle(color: Color(0xff222831)),
                      ),
                      onPressed: () {
                        context.pop();
                      },
                    ))
              ],
            );
          }),
        )));
  }
}
