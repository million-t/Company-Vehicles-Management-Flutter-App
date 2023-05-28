import 'package:flutter/material.dart';
import '../models/vehicle_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/vehicle_repository.dart';
import '../blocs/blocs.dart';
import 'package:go_router/go_router.dart';

class VehicleDeleteDialog {
  Widget buildDeleteAlert(BuildContext context,
      VehicleRepository vehicleRepository, Vehicle vehicle) {
    return AlertDialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Color(0xff393E46),
        title: const Text(
          'Delete Report?',
          style: TextStyle(color: Colors.white),
        ),
        content: BlocProvider(create: (context) {
          return VehicleBloc(
            vehicleRepository: vehicleRepository,
          );
        }, child: SingleChildScrollView(
          child: BlocBuilder<VehicleBloc, VehicleState>(builder: (_, state) {
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
                        VehicleEvent event = VehicleDelete(vehicle.id);
                        final vehicleBloc = BlocProvider.of<VehicleBloc>(_);
                        vehicleBloc.add(event);
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
