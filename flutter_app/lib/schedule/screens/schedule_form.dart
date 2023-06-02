import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../blocs/blocs.dart';
import 'dart:convert';

import 'package:go_router/go_router.dart';
import '../repository/schedule_repository.dart';
import '../models/schedule_model.dart';
import '../blocs/schedule_bloc.dart';
import '../blocs/schedule_state.dart';
import '../../auth/blocs/blocs.dart';
import '../../auth/models/userModel.dart';
import '../../auth/repository/user_repository.dart';
import '../../vehicle/blocs/blocs.dart';
import '../../vehicle/models/vehicle_model.dart';
import '../../vehicle/repository/vehicle_repository.dart';

class ManagerSchedule extends StatefulWidget {
  const ManagerSchedule({super.key});

  @override
  State<ManagerSchedule> createState() => _ManagerScheduleState();
}

class _ManagerScheduleState extends State<ManagerSchedule> {
  ScheduleRepository scheduleRepository = ScheduleRepository();
  VehicleRepository vehicleRepository = VehicleRepository();
  UserRepository userRepository = UserRepository();
  List drivers = [];
  List vehicles = [];

  Vehicle? selectedCar;
  String? selectedDriver;
  DateTime? startDate;
  DateTime? endDate;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ScheduleBloc>(
            create: (context) =>
                ScheduleBloc(scheduleRepository: scheduleRepository),
          ),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(userRepository: userRepository),
          ),
          BlocProvider<VehicleBloc>(
            create: (context) =>
                VehicleBloc(vehicleRepository: vehicleRepository),
          ),
        ],
        child: MultiBlocListener(
            listeners: [
              BlocListener<UserBloc, UserState>(
                // listenWhen: (previous, current) => drivers == [],
                listener: (context, state) {
                  BlocProvider.of<UserBloc>(context).add(UserLoad());

                  if (state is UserOperationSuccess) {
                    // setState(() {
                    drivers = state.users.toList();
                    // });
                  }
                },
              ),
            ],
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocBuilder<VehicleBloc, VehicleState>(
                    buildWhen: (previous, current) =>
                        previous is VehicleLoading &&
                        current is! VehicleLoading,
                    builder: (context, state) {
                      BlocProvider.of<VehicleBloc>(context).add(VehicleLoad());
                      if (state is VehicleOperationSuccess) {
                        // setState(() {
                        vehicles = state.vehicles.toList();
                        // });
                      }
                      return DropdownButtonFormField<Vehicle?>(
                        value: selectedCar,
                        items: vehicles.map((car) {
                          return DropdownMenuItem<Vehicle?>(
                            value: car,
                            child: Row(children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                constraints: BoxConstraints(
                                    maxWidth: 450.0, minHeight: 50.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.memory(
                                      base64Decode(car.image.split(',').last)),
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Text("${car.name} - ${car.licensePlateNumber}")
                            ]),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCar = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Select a vehicle',
                          border: OutlineInputBorder(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16.0),
                  BlocBuilder<UserBloc, UserState>(
                      buildWhen: (previous, current) => current is UserLoading,
                      builder: (context, state) {
                        BlocProvider.of<UserBloc>(context).add(UserLoad());
                        if (state is UserOperationSuccess) {
                          // setState(() {
                          drivers = state.users.toList();

                          // });
                        }

                        return DropdownButtonFormField<String?>(
                          value: selectedDriver,
                          items: drivers.map((driver) {
                            return DropdownMenuItem<String?>(
                              value: driver.id,
                              child: Text(driver.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDriver = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Select a driver',
                            border: OutlineInputBorder(),
                          ),
                        );
                      }),
                  SizedBox(height: 16.0),
                  TextFormField(
                    // initialValue: startDate.toString(),
                    decoration: InputDecoration(
                      labelText: 'Start Date',
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2025, 12),
                      );
                      if (picked != null && picked != startDate) {
                        setState(() {
                          startDate = picked;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                      // initialValue: endDate.toString(),
                      decoration: InputDecoration(
                        labelText: 'End Date',
                        border: OutlineInputBorder(),
                      ),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2025, 12),
                        );
                        if (picked != null && picked != endDate) {
                          setState(() {
                            endDate = picked;
                          });
                        }
                      }),
                  SizedBox(height: 36.0),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Color.fromARGB(255, 255, 211, 109))),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Color(0xff222831)),
                    ),
                    onPressed: () {
                      // String driverName;
                      // for (var driver in drivers) {
                      //   if (driver.id == selectedDriver!) {
                      //     driverName = driver.name;
                      //   }
                      // }
                      Schedule newSchedule = Schedule(
                          driverId: selectedDriver!,
                          vehicleId: selectedCar!.id,
                          image: selectedCar!.image,
                          licensePlateNumber: selectedCar!.licensePlateNumber,
                          start: startDate!,
                          end: endDate!);

                      ScheduleEvent event = ScheduleCreate(newSchedule);

                      // context.read().add(event);
                      // ;
                      // Navigator.of(context).pop();
                      BlocProvider.of<ScheduleBloc>(context).add(event);
                      // if (state is! ScheduleOperationFailure) {
                      //   print('working');
                      //   // context.pop();
                      // } else {
                      //   print('pseudo failure');
                      // }
                    },
                  )
                ])
            // Center(
            //   child: BlocBuilder<ScheduleBloc, ScheduleState>(
            //     builder: (_, state) {
            //       // BlocProvider.of<ScheduleBloc>(_).add();
            //       if (state is ScheduleOperationFailure) {
            //         return const Text('Could not fetch schedule.');
            //       }

            //       if (state is ScheduleOperationSuccess) {
            //         final schedules = state.schedules;

            //         return ListView.builder(
            //           itemCount: schedules.length,
            //           itemBuilder: (_, idx) => ListTile(
            //             title: Text(schedules.elementAt(idx).driverId),
            //             subtitle: Text(schedules.elementAt(idx).managerId),
            //           ),
            //         );
            //       }

            //       return const CircularProgressIndicator();
            //     },
            //   ),
            // )
            ));
  }
}
