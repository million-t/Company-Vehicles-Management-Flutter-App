class Issue {
  String id;
  String driverId;
  String managerId;
  String driverName;
  final String content;
  String status;
  String response;

  Issue({
    this.id = '',
    this.driverId = '',
    this.managerId = '',
    this.driverName = '',
    required this.content,
    this.response = '',
    this.status = "pending",
  });

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      id: json['_id'],
      driverId: json['driver_id'],
      driverName: json['driver_name'],
      managerId: json['manager_id'],
      response: json['response'],
      content: json['content'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["_id"] = id;
    json["driver_id"] = driverId;
    json["driver_name"] = driverName;
    json["manager_id"] = managerId;
    json["response"] = response;
    json["content"] = content;
    json["status"] = status;
    return json;
  }
}
