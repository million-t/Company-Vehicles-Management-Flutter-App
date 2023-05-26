import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/userModel.dart';
import '../repository/user_repository.dart';
import 'blocs.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserLoading()) {
    // on<UserLoad>((event, emit) async {
    //   emit(UserLoading());
    //   try {
    //     final courses = await userRepository.fetchAll();
    //     emit(UserOperationSuccess(courses));
    //   } catch (error) {
    //     emit(UserOperationFailure(error));
    //   }
    // });

    on<UserSignup>((event, emit) async {
      try {
        User user = await userRepository.signup(event.user);

        emit(UserLogedin(user));
      } catch (error) {
        emit(UserOperationFailure(error));
      }
    });
    on<UserLogin>((event, emit) async {
      try {
        User user = await userRepository.login(event.email, event.password);
        emit(UserLogedin(user));
      } catch (error) {
        emit(UserOperationFailure(error));
      }
    });

    // on<CourseUpdate>((event, emit) async {
    //   try {
    //     await courseRepository.update(event.id, event.course);
    //     final courses = await courseRepository.fetchAll();
    //     emit(CourseOperationSuccess(courses));
    //   } catch (error) {
    //     emit(CourseOperationFailure(error));
    //   }
    // });

    // on<CourseDelete>((event, emit) async {
    //   try {
    //     await courseRepository.delete(event.id);
    //     final courses = await courseRepository.fetchAll();
    //     emit(CourseOperationSuccess(courses));
    //   } catch (error) {
    //     emit(CourseOperationFailure(error));
    //   }
    // });
  }
}
