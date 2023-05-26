class User {
  final String name;
  final String email;
  final String managerId;
  final String type;
  final String? password;
  final String? id;
  final String? token;

  User({
    this.token,
    this.id = '',
    this.password = '',
    required this.name,
    required this.email,
    required this.managerId,
    required this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        name: json['name'],
        email: json['email'],
        managerId: json['manager_id'] ?? '',
        type: json['type'],
        token: json['token']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'manager_id': managerId,
      'type': type,
      'password': password,
    };
  }
}
