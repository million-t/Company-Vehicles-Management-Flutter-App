import 'package:flutter/material.dart';
import '../models/vehicle_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/vehicle_repository.dart';
import '../blocs/blocs.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class VehicleCreateUpdate extends StatefulWidget {
  @override
  _VehicleCreateUpdateState createState() => _VehicleCreateUpdateState();
}

class _VehicleCreateUpdateState extends State<VehicleCreateUpdate> {
  final txtName = TextEditingController();
  final txtLicensePlateNumber = TextEditingController();
  String? _base64Image;

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();

      final base64Image = base64Encode(bytes);
      setState(() {
        _base64Image = base64Image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // List reports = [];
    VehicleRepository vehicleRepository = VehicleRepository();
    return BlocProvider(
        create: (context) {
          return VehicleBloc(
            vehicleRepository: vehicleRepository,
          );
        },
        child: Scaffold(
            backgroundColor: Color(0xff222831),
            appBar: AppBar(
              title: const Text("Create Report"),
              backgroundColor: const Color(0xff393E46),
            ),
            body: BlocBuilder<VehicleBloc, VehicleState>(builder: (_, state) {
              return Container(
                padding: EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextField(
                          controller: txtName,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              labelText: 'Vehicle Name',
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 0.509)),
                              focusColor: Colors.amber)),
                      TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: txtLicensePlateNumber,
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.509)),
                            labelText: 'License Plate Number'),
                      ),
                      const SizedBox(height: 32.0),
                      if (_base64Image != null)
                        Image.memory(
                          base64Decode(_base64Image!),
                          width: 300,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _getImage,
                        child: Text('Select Image'),
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
                              Vehicle newVehicle = Vehicle(
                                name: txtName.text,
                                licensePlateNumber: txtLicensePlateNumber.text,
                                image: _base64Image!,
                              );

                              VehicleEvent event = VehicleCreate(
                                newVehicle,
                              );

                              // context.read().add(event);
                              // ;
                              // Navigator.of(context).pop();
                              BlocProvider.of<VehicleBloc>(_).add(event);
                              if (state is! VehicleOperationFailure) {
                                print('working');
                                // context.pop();
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
