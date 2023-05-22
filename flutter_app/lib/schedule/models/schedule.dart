class Schedule {
  final String id;
  final String driverId;
  final String managerId;
  final String vehicleId;

  final DateTime start;
  final DateTime end;

  Schedule(
      {required this.id,
      required this.driverId,
      required this.managerId,
      required this.vehicleId,
      required this.start,
      required this.end});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
        id: json['_id'],
        driverId: json['driver_name'],
        managerId: json['manager_name'],
        vehicleId: json['vehicle_id'],
        start: DateTime.parse(json['start']),
        end: DateTime.parse(json['end']));
  }

  toJson() {}
}
