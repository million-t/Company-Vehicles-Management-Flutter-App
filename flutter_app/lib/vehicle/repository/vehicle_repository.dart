import '../data_providers/vehicle_data_provider.dart';
import '../models/vehicle_model.dart';

class VehicleRepository {
  final VehicleDataProvider dataProvider = VehicleDataProvider();
  VehicleRepository();

  Future<Vehicle> create(Vehicle vehicle, String token) async {
    return dataProvider.create(vehicle, token);
  }

  Future<Vehicle> update(String id, Vehicle vehicle, String token) async {
    return dataProvider.update(id, vehicle, token);
  }

  Future<List<Vehicle>> getAllByManager(String token) async {
    return dataProvider.getAllByManager(token);
  }

  Future<void> delete(String id, String token) async {
    dataProvider.delete(id, token);
  }
}
