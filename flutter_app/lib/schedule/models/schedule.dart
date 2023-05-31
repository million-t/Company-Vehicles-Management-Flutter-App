class Schedule {
  String id;
  String driverId;
  String driverName;
  String managerId;
  final String vehicleId;
  final String image;
  final String licensePlateNumber;

  var start;
  var end;

  Schedule(
      {this.id = '',
      this.driverId = '',
      this.managerId = '',
      this.driverName = '',
      required this.vehicleId,
      required this.image,
      required this.licensePlateNumber,
      required this.start,
      required this.end});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
        id: json['_id'],
        driverId: json['driver_id'],
        managerId: json['manager_id'],
        vehicleId: json['vehicle_id'],
        licensePlateNumber: json['license_plate_number'],
        image: json['image'],
        start: json['start'],
        end: json['end']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["_id"] = id;
    json["vehicle_id"] = vehicleId;
    json["license_plate_number"] = licensePlateNumber;
    json["image"] = image;
    json["start"] = start;
    json["end"] = end;
    json["driver_id"] = driverId;
    json["manager_id"] = managerId;
    return json;
  }
}
