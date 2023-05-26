import 'package:flutter/material.dart';
import '../models/report_model.dart';
import 'reportDialogue.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../repository/report_repository.dart';
import 'package:go_router/go_router.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    ReportDialog dialog = ReportDialog();
    // helper = DbHelper();
    // showData(this.shoppingList.id);
    List reports = [];
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
            title: Text("Reports"),
            backgroundColor: const Color(0xff393E46),
          ),
          body: BlocBuilder<ReportBloc, ReportState>(
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
                      return Dismissible(
                        key: Key(reports[index].id),
                        onDismissed: (direction) {
                          String strName = reports[index].vehicleName;
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
                                title: Text(
                                  reports[index].vehicleName,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255,
                                        255), // set the font color
                                    fontSize: 14.0, // set the font size
                                    // fontWeight:
                                    //     FontWeight.bold, // set the font weight
                                  ),
                                ),
                                subtitle: Text(
                                    '\n\nVolume: ${reports[index].litres} \nLitres \nDistance: ${reports[index].distance}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    )),
                                onTap: () {},
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: _,
                                        builder: (BuildContext _) =>
                                            dialog.buildAlert(
                                                _,
                                                reportRepository,
                                                reports[index],
                                                false));
                                  },
                                ),
                              ),
                            )),
                      );
                    });
              }

              return Center(child: const CircularProgressIndicator());
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.go('/report/details');
            },
            child: Icon(Icons.add, color: Color(0xff222831)),
            backgroundColor: Color.fromARGB(255, 255, 211, 109),
          ),
        ));
  }
}
