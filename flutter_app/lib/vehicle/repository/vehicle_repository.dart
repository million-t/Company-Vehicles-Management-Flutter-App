import '../data_providers/vehicle_data_provider.dart';
import '../models/vehicle_model.dart';
import '../../util/local_provider.dart';

class VehicleRepository {
  final VehicleDataProvider dataProvider = VehicleDataProvider();
  LocalDb localDb = LocalDb();

  VehicleRepository();

  Future<Vehicle> create(Vehicle vehicle, String token) async {
    return dataProvider.create(vehicle, token);
  }

  Future<Vehicle> update(String id, Vehicle vehicle, String token) async {
    return dataProvider.update(id, vehicle, token);
  }

  Future<List<Vehicle>> getAllByManager(String token) async {
    try {
      final remote = await dataProvider.getAllByManager(token);
      await localDb
          .saveVehicles(remote.map((vehicle) => vehicle.toJson()).toList());
      return remote;
    } catch (_) {
      final localData = await localDb.getVehicles();
      return localData;
    }
  }

  Future<void> delete(String id, String token) async {
    dataProvider.delete(id, token);
  }
}
