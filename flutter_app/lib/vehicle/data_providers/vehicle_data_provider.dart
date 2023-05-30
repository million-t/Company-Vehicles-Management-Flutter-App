import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../util/serverIp.dart';
import '../models/vehicle_model.dart';

class VehicleDataProvider {
  static final String _baseUrl = "${Server().ip}/vehicle";

  Future<Vehicle> create(Vehicle vehicle, String token) async {
    final http.Response response = await http.post(Uri.parse(_baseUrl),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": token
        },
        body: jsonEncode({
          "manager_id": vehicle.managerId,
          "name": vehicle.name,
          "image": vehicle.image,
          "license_plate_number": vehicle.licensePlateNumber
        }));

    if (response.statusCode == 200) {
      return Vehicle.fromJson(jsonDecode(response.body));
    }
    {
      throw Exception("Failed to create Vehicle");
    }
  }

  Future<Vehicle> getReport(String id, String token) async {
    final response = await http.get(Uri.parse("$_baseUrl/$id"));

    if (response.statusCode == 200) {
      return Vehicle.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetching Vehicle failed");
    }
  }

  Future<List<Vehicle>> getAllByManager(String token) async {
    final response = await http.get(Uri.parse(_baseUrl),
        headers: <String, String>{"Authorization": token});

    if (response.statusCode == 200) {
      final reports = jsonDecode(response.body) as List;

      return reports.map((c) => Vehicle.fromJson(c)).toList();
    } else {
      throw Exception("Could not fetch Vehicle.");
    }
  }

  Future<Vehicle> update(String id, Vehicle vehicle, String token) async {
    final response = await http.patch(Uri.parse("$_baseUrl/$id"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": token
        },
        body: jsonEncode({
          "manager_id": vehicle.managerId,
          "name": vehicle.name,
          "image": vehicle.image,
          "license_plate_number": vehicle.licensePlateNumber
        }));

    if (response.statusCode == 200) {
      return Vehicle.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the Vehicle");
    }
  }

  Future<void> delete(String id, String token) async {
    final response = await http.delete(Uri.parse("$_baseUrl/$id"),
        headers: <String, String>{"Authorization": token});
    if (response.statusCode != 204) {
      throw Exception("Field to delete the Vehicle");
    }
    return;
  }
}
