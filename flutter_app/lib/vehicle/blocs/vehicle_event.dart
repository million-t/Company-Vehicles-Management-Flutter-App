import 'package:equatable/equatable.dart';

import '../models/vehicle_model.dart';

abstract class VehicleEvent extends Equatable {
  const VehicleEvent();
}

class VehicleLoad extends VehicleEvent {
  const VehicleLoad();

  @override
  List<Object> get props => [];
}

class VehicleCreate extends VehicleEvent {
  final Vehicle vehicle;

  const VehicleCreate(this.vehicle);

  @override
  List<Object> get props => [vehicle];

  @override
  String toString() => 'vehicle Created {vehicle Id: ${vehicle.id}';
}

class VehicleUpdate extends VehicleEvent {
  final String id;
  final Vehicle vehicle;

  const VehicleUpdate(this.id, this.vehicle);

  @override
  List<Object> get props => [id, vehicle];

  @override
  String toString() => 'Vehicle Updated {vehicle Id: $id}';
}

class VehicleDelete extends VehicleEvent {
  final String id;

  const VehicleDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Vehicle Deleted {vehicle Id: $id}';

  @override
  bool? get stringify => true;
}
