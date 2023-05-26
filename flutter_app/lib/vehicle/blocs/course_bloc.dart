// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../repository/course_repository.dart';
// import 'blocs.dart';

// class CourseBloc extends Bloc<CourseEvent, CourseState> {
//   final CourseRepository courseRepository;

//   CourseBloc({required this.courseRepository}) : super(CourseLoading()) {
//     on<CourseLoad>((event, emit) async {
//       emit(CourseLoading());
//       try {
//         final courses = await courseRepository.fetchAll();
//         emit(CourseOperationSuccess(courses));
//       } catch (error) {
//         emit(CourseOperationFailure(error));
//       }
//     });

//     on<CourseCreate>((event, emit) async {
//       try {
//         await courseRepository.create(event.course);
//         final courses = await courseRepository.fetchAll();
//         emit(CourseOperationSuccess(courses));
//       } catch (error) {
//         emit(CourseOperationFailure(error));
//       }
//     });

//     on<CourseUpdate>((event, emit) async {
//       try {
//         await courseRepository.update(event.id, event.course);
//         final courses = await courseRepository.fetchAll();
//         emit(CourseOperationSuccess(courses));
//       } catch (error) {
//         emit(CourseOperationFailure(error));
//       }
//     });

//     on<CourseDelete>((event, emit) async {
//       try {
//         await courseRepository.delete(event.id);
//         final courses = await courseRepository.fetchAll();
//         emit(CourseOperationSuccess(courses));
//       } catch (error) {
//         emit(CourseOperationFailure(error));
//       }
//     });
//   }
// }
