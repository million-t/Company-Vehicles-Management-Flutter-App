import 'package:flutter/material.dart';
import '../models/vehicle_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/vehicle_repository.dart';
import '../blocs/blocs.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class VehicleUpdateDialog {
  final txtLicensePlateNumber = TextEditingController();
  final txtName = TextEditingController();
  String? _base64Image;
  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();

      final base64Image = base64Encode(bytes);

      _base64Image = base64Image;
    }
  }

  Widget buildAlert(BuildContext context, VehicleRepository vehicleRepository,
      Vehicle vehicle) {
    txtLicensePlateNumber.text = vehicle.licensePlateNumber;
    txtName.text = vehicle.name;
    _base64Image = vehicle.image;

    return AlertDialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Color(0xff393E46),
        title: const Text(
          "Edit Report",
          style: TextStyle(color: Colors.white),
        ),
        content: BlocProvider(create: (context) {
          return VehicleBloc(
            vehicleRepository: vehicleRepository,
          );
        }, child: SingleChildScrollView(
          child: BlocBuilder<VehicleBloc, VehicleState>(builder: (_, state) {
            return Column(
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
                        Vehicle newVehicle = Vehicle(
                          name: txtName.text,
                          licensePlateNumber: txtLicensePlateNumber.text,
                          image: _base64Image!,
                          id: vehicle.id,
                          managerId: vehicle.managerId,
                        );

                        VehicleEvent event = VehicleUpdate(
                          vehicle.id,
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
            );
          }),
        )));
  }
}
