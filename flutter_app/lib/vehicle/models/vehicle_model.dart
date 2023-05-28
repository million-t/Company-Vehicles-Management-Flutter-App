class Vehicle {
  String id;
  String managerId;
  final String image;
  final String name;
  final String licensePlateNumber;

  Vehicle(
      {this.id = '',
      this.managerId = '',
      required this.image,
      required this.name,
      required this.licensePlateNumber});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
        id: json['_id'],
        managerId: json['manager_id'],
        name: json['name'],
        licensePlateNumber: json['license_plate_number'],
        image: json['image']);
  }
}
