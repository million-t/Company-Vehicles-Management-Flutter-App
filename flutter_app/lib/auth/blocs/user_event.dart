import 'package:equatable/equatable.dart';

import '../models/userModel.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserLoad extends UserEvent {
  const UserLoad();

  @override
  List<Object> get props => [];
}

class UserSignup extends UserEvent {
  final User user;

  const UserSignup(this.user);

  @override
  List<Object> get props => [user.email];

  @override
  String toString() => 'User Created {user email: ${user.email}}';
}

class UserLogin extends UserEvent {
  final String email;
  final String password;

  const UserLogin(this.email, this.password);

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'User logged in {user email: $email}';
  @override
  bool? get stringify => true;
}

class UserUpdate extends UserEvent {
  // final int id;
  final User user;

  const UserUpdate(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'user Updated {user email: ${user.email}}';
}

class UserDelete extends UserEvent {
  const UserDelete();

  @override
  List<Object> get props => [];

  @override
  toString() => 'User Deleted:}';

  @override
  bool? get stringify => true;
}
