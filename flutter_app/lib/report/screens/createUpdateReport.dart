import 'package:flutter/material.dart';
import '../models/report_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/report_repository.dart';
import '../blocs/blocs.dart';
import 'package:go_router/go_router.dart';

class ReportCreateUpdate extends StatefulWidget {
  bool isNew;
  Report? report;
  ReportCreateUpdate({required this.isNew, this.report});

  @override
  _ReportCreateUpdateState createState() =>
      _ReportCreateUpdateState(isNew, this.report);
}

class _ReportCreateUpdateState extends State<ReportCreateUpdate> {
  final txtDistance = TextEditingController();
  final txtLitres = TextEditingController();
  final txtVehicleName = TextEditingController();
  final txtPrice = TextEditingController();
  bool isNew;
  Report? report;
  _ReportCreateUpdateState(this.isNew, this.report);

  @override
  Widget build(BuildContext context) {
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
              title: Text(isNew ? "Create" : "Update"),
              backgroundColor: const Color(0xff393E46),
            ),
            body: BlocBuilder<ReportBloc, ReportState>(builder: (_, state) {
              return Container(
                padding: EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextField(
                          controller: txtVehicleName,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 0.509)),
                              hintText: 'Vehicle Name',
                              focusColor: Colors.amber)),
                      TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: txtLitres,
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.509)),
                            hintText: 'Litres'),
                      ),
                      TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: txtPrice,
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.509)),
                            hintText: 'Price'),
                      ),
                      TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: txtDistance,
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.509)),
                            hintText: 'Distance'),
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        Color.fromARGB(255, 255, 211, 109))),
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Color(0xff222831)),
                            ),
                            onPressed: () {
                              Report newReport;
                              if (!isNew) {
                                newReport = Report(
                                    distance: txtDistance.text,
                                    litres: txtLitres.text,
                                    vehicleName: txtVehicleName.text,
                                    price: txtPrice.text,
                                    id: report!.id,
                                    driverId: report!.driverId,
                                    managerId: report!.managerId,
                                    driverName: report!.driverName);
                              } else {
                                newReport = Report(
                                    distance: txtDistance.text,
                                    litres: txtLitres.text,
                                    vehicleName: txtVehicleName.text,
                                    price: txtPrice.text,
                                    id: "",
                                    driverId: "",
                                    managerId: "",
                                    driverName: "");
                              }
                              ReportEvent event = !isNew
                                  ? ReportUpdate(
                                      report!.id,
                                      newReport,
                                    )
                                  : ReportCreate(
                                      newReport,
                                    );

                              // context.read().add(event);
                              // ;
                              // Navigator.of(context).pop();
                              BlocProvider.of<ReportBloc>(_).add(event);
                              if (state is! ReportOperationFailure) {
                                context.pop();
                              } else {
                                print('pseudo failure');
                              }
                            },
                          ))
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(30.0))))
                    ],
                  ),
                ),
              );
            })));
  }

// BlocProvider(
//         create: (context) {
//           return ReportBloc(
//             reportRepository: reportRepository,
//           );
//         },
//         child:
  // Future showData(int idList) async {
  //   await helper!.openDb();
  //   items = await helper!.getItems(idList);
  //   setState(() {
  //     items = items;
  //   });
  // }
}
