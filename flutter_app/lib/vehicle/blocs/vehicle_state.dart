import 'package:equatable/equatable.dart';

import '../models/vehicle_model.dart';

abstract class VehicleState extends Equatable {
  const VehicleState();

  @override
  List<Object> get props => [];
}

class VehicleLoading extends VehicleState {}

class VehicleOperationSuccess extends VehicleState {
  final Iterable<Vehicle> vehicles;

  const VehicleOperationSuccess([this.vehicles = const []]);

  @override
  List<Object> get props => [vehicles];
}

class VehicleOperationFailure extends VehicleState {
  final Object error;

  const VehicleOperationFailure(this.error);
  @override
  List<Object> get props => [error];
}
