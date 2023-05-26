class Response {
  final String id;
  final String driverId;
  final String managerId;
  final String content;
  final String issueId;

  Response(
      {required this.id,
      required this.driverId,
      required this.managerId,
      required this.content,
      required this.issueId});

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
      'content': content,
      'issue_id': issueId,
    };
  }
}
