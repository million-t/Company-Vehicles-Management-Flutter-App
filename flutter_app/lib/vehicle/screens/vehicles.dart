import 'package:flutter/material.dart';
import '../models/vehicle_model.dart';
// import 'reportDialogue.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../repository/vehicle_repository.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'vehicleDeleteDialog.dart';
import 'vehicleUpdateDialog.dart';

class VehicleScreen extends StatefulWidget {
  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  VehicleDeleteDialog deleteDialog = VehicleDeleteDialog();

  @override
  Widget build(BuildContext context) {
    VehicleUpdateDialog updateDialog = VehicleUpdateDialog();
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
            title: Text("Vehicles"),
            backgroundColor: const Color(0xff393E46),
          ),
          body: BlocBuilder<VehicleBloc, VehicleState>(
            buildWhen: (previousState, currentState) {
              return previousState is VehicleLoading &&
                  currentState is! VehicleLoading;
            },
            builder: (_, state) {
              BlocProvider.of<VehicleBloc>(_).add(VehicleLoad());
              if (state is VehicleOperationFailure) {
                return const Text('Could not Fetch!');
              }

              if (state is VehicleOperationSuccess) {
                final vehicles = state.vehicles.toList();

                return ListView.builder(
                    itemCount: (vehicles != null) ? vehicles.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: EdgeInsets.fromLTRB(9.0, 10.6, 9.0, 6.4),
                          child: Container(
                            // padding: EdgeInsets.fromLTRB(4.0, 2.6, 4.0, 1.4),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              // set the border color
                              borderRadius: BorderRadius.circular(
                                  6.0), // set the border radius
                            ),
                            child: Column(children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                width: MediaQuery.of(context).size.width,
                                constraints: const BoxConstraints(
                                    maxWidth: 450.0, minHeight: 50.0),
                                child: ClipRRect(
                                  // borderRadius: BorderRadius.circular(8),
                                  child: Image.memory(base64Decode(
                                      vehicles[index].image.split(',').last)),
                                ),
                              ),
                              ListTile(
                                  // contentPadding:
                                  //     EdgeInsets.symmetric(vertical: 16.0),
                                  title: Text(
                                    vehicles[index].name,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255,
                                          255), // set the font color
                                      fontSize: 14.0, // set the font size
                                    ),
                                  ),
                                  subtitle: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 8.0, 6.0, 0.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "License Plate Number:  ${vehicles[index].licensePlateNumber}",
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255,
                                                    255,
                                                    255,
                                                    255), // set the font color
                                                fontSize:
                                                    12.0, // set the font size
                                              ),
                                            )
                                          ])),
                                  onTap: () {},
                                  trailing: PopupMenuButton(
                                    color: Colors.white,
                                    surfaceTintColor: Color(0xff393E46),
                                    onSelected: (value) {
                                      if (value == 'update') {
                                        showDialog(
                                            context: _,
                                            builder: (BuildContext _) =>
                                                updateDialog.buildAlert(
                                                    _,
                                                    vehicleRepository,
                                                    vehicles[index]));
                                      } else if (value == 'delete') {
                                        showDialog(
                                            context: _,
                                            builder: (BuildContext _) =>
                                                deleteDialog.buildDeleteAlert(
                                                    _,
                                                    vehicleRepository,
                                                    vehicles[index]));
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
                            ]),
                          ));
                    });
              }

              return Center(child: const CircularProgressIndicator());
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.go('/settings/vehicles/createVehicle');
            },
            child: Icon(Icons.add, color: Color(0xff222831)),
            backgroundColor: Color.fromARGB(255, 255, 211, 109),
          ),
        ));
  }
}
