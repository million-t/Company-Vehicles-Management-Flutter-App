import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'schedule/screens/schedules.dart';
import 'schedule/bloc_observer.dart';
import 'schedule/blocs/blocs.dart';
import 'schedule/data_providers/schedule_remote_provider.dart';
import 'schedule/repository/schedule_repository.dart';
// import 'schedule/screens/schedule_route.dart';

// void main() {
//   final ScheduleRepository scheduleRepository = ScheduleRepository();
//   // Bloc.transformer = customEventTransformer();
//   // Bloc.observer = AppBlocObserver();
//   runApp(MyApp(scheduleRepository: scheduleRepository));
//   // runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final ScheduleRepository scheduleRepository;
//   const MyApp({Key? key, required this.scheduleRepository}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Calendar Demo',
//       home: MyHomePage(),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'course/bloc_observer.dart';
// import 'course/blocs/blocs.dart';
// import 'course/data_providers/course_data_provider.dart';
// import 'course/repository/course_repository.dart';
// import 'course/screens/course_route.dart';

void main() {
  final ScheduleRepository scheduleRepository = ScheduleRepository();

  Bloc.observer = AppBlocObserver();
  runApp(ScheduleApp(scheduleRepository: scheduleRepository));
  // runApp(MyApp());
}

class ScheduleApp extends StatelessWidget {
  final ScheduleRepository scheduleRepository;

  const ScheduleApp({Key? key, required this.scheduleRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: scheduleRepository,
      child: BlocProvider(
        create: (context) =>
            ScheduleBloc(scheduleRepository: scheduleRepository)
              ..add(const ScheduleLoad()),
        child: MaterialApp(
          title: 'VehMan',
          home: SchedulesList(),
        ),
      ),
    );
  }
}
