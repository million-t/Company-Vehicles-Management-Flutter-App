// import 'package:equatable/equatable.dart';

// import '../models/course.dart';

// abstract class CourseEvent extends Equatable {
//   const CourseEvent();
// }

// class CourseLoad extends CourseEvent {
//   const CourseLoad();

//   @override
//   List<Object> get props => [];
// }

// class CourseCreate extends CourseEvent {
//   final Course course;

//   const CourseCreate(this.course);

//   @override
//   List<Object> get props => [course];

//   @override
//   String toString() => 'Course Created {course Id: ${course.id}}';
// }

// class CourseUpdate extends CourseEvent {
//   final int id;
//   final Course course;

//   const CourseUpdate(this.id, this.course);

//   @override
//   List<Object> get props => [id, course];

//   @override
//   String toString() => 'Course Updated {course Id: ${course.id}}';
// }

// class CourseDelete extends CourseEvent {
//   final int id;

//   const CourseDelete(this.id);

//   @override
//   List<Object> get props => [id];

//   @override
//   toString() => 'Course Deleted {course Id: $id}';

//   @override
//   bool? get stringify => true;
// }
