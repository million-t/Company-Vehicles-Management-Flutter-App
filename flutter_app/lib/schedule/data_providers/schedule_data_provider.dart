import 'dart:convert';
import '../../util/serverIp.dart';
import 'package:http/http.dart' as http;

import '../models/schedule_model.dart';

class ScheduleDataProvider {
  static final String _baseUrl = "${Server().ip}/schedule";

  Future<Schedule> create(Schedule schedule, String token) async {
    final http.Response response = await http.post(Uri.parse(_baseUrl),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": token
        },
        body: jsonEncode({
          "manager_id": schedule.managerId,
          "driver_id": schedule.driverId,
          "vehicle_id": schedule.vehicleId,
          "image": schedule.image,
          "license_plate_number": schedule.licensePlateNumber,
          "start": schedule.start.toString(),
          "end": schedule.end.toString(),
        }));

    if (response.statusCode == 200) {
      return Schedule.fromJson(jsonDecode(response.body));
    }
    {
      throw Exception("Failed to create Schedule");
    }
  }

  Future<Schedule> getSchedule(String id, String token) async {
    final response = await http.get(Uri.parse("$_baseUrl/$id"));

    if (response.statusCode == 200) {
      return Schedule.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetching Schedule failed");
    }
  }

  Future<List<Schedule>> getAllByDriver(String token) async {
    final response = await http.get(Uri.parse("$_baseUrl/driver"),
        headers: <String, String>{"Authorization": token});
    if (response.statusCode == 200) {
      final schedules = jsonDecode(response.body) as List;
      return schedules.map((c) => Schedule.fromJson(c)).toList();
    } else {
      throw Exception("Could not fetch Schedules.");
    }
  }

  Future<List<Schedule>> getAllToManager(String token) async {
    final response = await http.get(Uri.parse("$_baseUrl/manager"),
        headers: <String, String>{"Authorization": token});

    if (response.statusCode == 200) {
      final schedules = jsonDecode(response.body) as List;

      return schedules.map((c) => Schedule.fromJson(c)).toList();
    } else {
      throw Exception("Could not fetch Schedules.");
    }
  }

  Future<Schedule> update(String id, Schedule schedule, String token) async {
    final response = await http.patch(Uri.parse("$_baseUrl/$id"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": token
        },
        body: jsonEncode({
          "manager_id": schedule.managerId,
          "driver_name": schedule.driverId,
          "vehicle_id": schedule.vehicleId,
          "start": schedule.start.toString(),
          "end": schedule.end.toString(),
        }));

    if (response.statusCode == 200) {
      return Schedule.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the Schedule");
    }
  }

  Future<void> delete(String id, String token) async {
    final response = await http.delete(Uri.parse("$_baseUrl/$id"),
        headers: <String, String>{"Authorization": token});
    if (response.statusCode != 200) {
      throw Exception("Field to delete the Schedule");
    }
    return;
  }
}
