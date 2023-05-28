import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/repository/user_repository.dart';
import '../../auth/data_providers/remote_user_data_provider.dart';
import '../models/vehicle_model.dart';
import '../repository/vehicle_repository.dart';

import 'blocs.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleRepository vehicleRepository;
  final UserRepository userRepository = UserRepository();

  VehicleBloc({required this.vehicleRepository}) : super(VehicleLoading()) {
    on<VehicleLoad>((event, emit) async {
      try {
        String? token = await userRepository.getToken();

        final user = await userRepository.getUser();
        final userJson = jsonDecode(user);
        final type = userJson['type'];

        final List<Vehicle> vehicles;
        if (type == "manager") {
          vehicles = await vehicleRepository.getAllByManager(token.toString());
        } else {
          throw Exception("Unauthenticated.");
        }

        emit(VehicleOperationSuccess(vehicles));
      } catch (error) {
        emit(VehicleOperationFailure(error));
      }
    });

    on<VehicleCreate>((event, emit) async {
      try {
        final token = await userRepository.getToken();
        final user = await userRepository.getUser();
        final userJson = jsonDecode(user);
        final type = userJson['type'];
        event.vehicle.managerId = userJson['_id'];

        await vehicleRepository.create(event.vehicle, token!);
        emit(VehicleLoading());
        final List<Vehicle> vehicles =
            await vehicleRepository.getAllByManager(token.toString());

        print("created");

        emit(VehicleOperationSuccess(vehicles));
      } catch (error) {
        emit(VehicleOperationFailure(error));
      }
    });

    on<VehicleUpdate>((event, emit) async {
      try {
        final token = await userRepository.getToken();
        final user = await userRepository.getUser();
        final userJson = jsonDecode(user);
        final type = userJson['type'];
        event.vehicle.managerId = userJson['_id'];
        await vehicleRepository.update(
            event.id, event.vehicle, token.toString());
        emit(VehicleLoading());
        final List<Vehicle> vehicles;

        vehicles = await vehicleRepository.getAllByManager(token.toString());

        emit(VehicleOperationSuccess(vehicles));
      } catch (error) {
        emit(VehicleOperationFailure(error));
      }
    });

    on<VehicleDelete>((event, emit) async {
      try {
        final token = await userRepository.getToken();
        final user = await userRepository.getUser();
        final userJson = jsonDecode(user);
        final type = userJson['type'];

        await vehicleRepository.delete(event.id, token.toString());
        final List<Vehicle> vehicles;
        if (type.toString() == "manager") {
          vehicles = await vehicleRepository.getAllByManager(token.toString());
        } else {
          vehicles = [];
        }
        emit(VehicleOperationSuccess(vehicles));
      } catch (error) {
        emit(VehicleOperationFailure(error));
      }
    });
  }
}
