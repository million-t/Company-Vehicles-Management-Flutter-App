class Issue {
  final String id;
  final String driverId;
  final String managerId;
  final String driverName;
  final String content;
  final String status;

  Issue({
    required this.id,
    required this.driverId,
    required this.managerId,
    required this.driverName,
    required this.content,
    required this.status,
  });

  // factory Response.fromJson(Map<String, dynamic> json) {
  //   return Response(
  //     id: json['id'],
  //     name: json['name'],
  //     description: json['description'],
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      'driver_id': driverId,
      'manager_id': managerId,
      'driver_name': driverName,
      'content': content,
      'status': status
    };
  }
}
