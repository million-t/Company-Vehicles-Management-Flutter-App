import 'package:flutter/material.dart';
import '../models/report_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/report_repository.dart';
import '../blocs/blocs.dart';

class ReportDialog {
  final txtDistance = TextEditingController();
  final txtLitres = TextEditingController();
  final txtVehicleName = TextEditingController();
  final txtPrice = TextEditingController();

  Widget buildAlert(BuildContext context, ReportRepository reportRepository,
      Report report, bool isNew) {
    // DbHelper helper = DbHelper();
    // helper.openDb();
    if (!isNew) {
      txtDistance.text = report.distance;
      txtLitres.text = report.litres;
      txtVehicleName.text = report.vehicleName;
      txtPrice.text = report.price;
    }
    return AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Color(0xff393E46),
      title: Text(
        (isNew) ? 'New shopping item' : 'Edit shopping item',
        style: const TextStyle(color: Colors.white),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
                controller: txtVehicleName,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    hintStyle:
                        TextStyle(color: Color.fromRGBO(255, 255, 255, 0.509)),
                    hintText: 'Vehicle Name',
                    focusColor: Colors.amber)),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: txtLitres,
              decoration: const InputDecoration(
                  hintStyle:
                      TextStyle(color: Color.fromRGBO(255, 255, 255, 0.509)),
                  hintText: 'Litres'),
            ),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: txtPrice,
              decoration: const InputDecoration(
                  hintStyle:
                      TextStyle(color: Color.fromRGBO(255, 255, 255, 0.509)),
                  hintText: 'Price'),
            ),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: txtDistance,
              decoration: const InputDecoration(
                  hintStyle:
                      TextStyle(color: Color.fromRGBO(255, 255, 255, 0.509)),
                  hintText: 'Distance'),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Color.fromARGB(255, 255, 211, 109))),
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
                          id: report.id,
                          driverId: report.driverId,
                          managerId: report.managerId,
                          driverName: report.driverName);
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
                    ReportEvent event = isNew
                        ? ReportUpdate(
                            report.id,
                            newReport,
                          )
                        : ReportCreate(
                            newReport,
                          );
                    final reportBloc = BlocProvider.of<ReportBloc>(context);
                    reportBloc.add(event);
                    Navigator.of(context).pop();
                    // BlocProvider.of<ReportBloc>(context).add(event);
                  },
                ))
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(30.0))))
          ],
        ),
      ),
    );
  }
}
