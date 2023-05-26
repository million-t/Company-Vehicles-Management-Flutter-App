class Report {
  String id;
  String managerId;
  String driverName;
  final String vehicleName;
  final String distance;
  final String litres;
  final String price;
  String driverId;

  Report(
      {this.id = '',
      this.driverId = '',
      this.managerId = '',
      this.driverName = '',
      required this.vehicleName,
      required this.litres,
      required this.distance,
      required this.price});

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['_id'],
      driverId: json['driver_id'],
      driverName: json['driver_name'],
      managerId: json['manager_id'],
      vehicleName: json['vehicle_name'],
      distance: json['distance'],
      price: json['price'],
      litres: json['litres'],
    );
  }
}
