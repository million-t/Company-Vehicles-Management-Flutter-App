import 'package:flutter/material.dart';
import '../models/issueModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/issue_repository.dart';
import '../blocs/blocs.dart';
import 'package:go_router/go_router.dart';

class IssueDialog {
  final txtContent = TextEditingController();
  final txtResponse = TextEditingController();

  Widget buildAlert(BuildContext context, IssueRepository issueRepository,
      Issue issue, bool isDriver, bool isNew) {
    txtContent.text = issue.content;
    txtResponse.text = issue.response;

    return AlertDialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Color(0xff393E46),
        title: Text(
          isNew
              ? 'New Issue'
              : isDriver
                  ? "Edit Issue"
                  : "Respond",
          style: TextStyle(color: Colors.white),
        ),
        content: BlocProvider(create: (context) {
          return IssueBloc(
            issueRepository: issueRepository,
          );
        }, child: SingleChildScrollView(
          child: BlocBuilder<IssueBloc, IssueState>(builder: (_, state) {
            return Column(
              children: <Widget>[
                SizedBox(height: 8),
                TextField(
                  controller: txtContent,
                  enabled: isDriver,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Enter issue here...',
                    border: isDriver ? OutlineInputBorder() : null,
                  ),
                ),
                SizedBox(height: 32.0),
                Visibility(
                  visible: !isNew,
                  child: TextField(
                    controller: txtResponse,
                    enabled: !isDriver,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: !isDriver ? 'Respond here...' : '',
                      border: !isDriver ? OutlineInputBorder() : null,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  const Color.fromARGB(255, 255, 211, 109))),
                      child: const Text(
                        'Send',
                        style: TextStyle(color: Color(0xff222831)),
                      ),
                      onPressed: () {
                        Issue newIssue;
                        if (isNew) {
                          newIssue = Issue(content: txtContent.text);
                        } else {
                          print(112233);
                          newIssue = Issue(
                              response: txtResponse.text,
                              content: txtContent.text,
                              status: isDriver ? issue.status : 'resolved');
                        }

                        IssueEvent event = isNew
                            ? IssueCreate(newIssue)
                            : IssueUpdate(
                                issue.id,
                                newIssue,
                              );
                        final reportBloc = BlocProvider.of<IssueBloc>(_);
                        reportBloc.add(event);
                        context.pop();
                        // BlocProvider.of<ReportBloc>(context).add(event);
                      },
                    ))
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30.0))))
              ],
            );
          }),
        )));
  }
}
