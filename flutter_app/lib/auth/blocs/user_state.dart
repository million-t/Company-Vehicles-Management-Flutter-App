import 'package:equatable/equatable.dart';

import '../models/userModel.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserLogedin extends UserState {
  final User user;
  const UserLogedin(this.user);

  @override
  List<Object> get props => [user.email];
}

class UserOperationSuccess extends UserState {
  final Iterable<User> users;

  const UserOperationSuccess([this.users = const []]);

  @override
  List<Object> get props => [users];
}

class UserOperationFailure extends UserState {
  final Object error;

  const UserOperationFailure(this.error);
  @override
  List<Object> get props => [error];
}
