import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../blocs/schedule_bloc.dart';
import '../blocs/schedule_state.dart';
// import 'course_add_update.dart';
// import 'course_detail.dart';
// import 'course_route.dart';

class SchedulesList extends StatelessWidget {
  // static const routeName = '/';

  const SchedulesList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(DateTime.now().year - 1, 12, 31),
            lastDay: DateTime(DateTime.now().year + 1, 12, 31),
            focusedDay: _selectedDay,
            // calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
              });
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
          ),
          Expanded(
            child: BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (_, state) {
                if (state is ScheduleOperationFailure) {
                  return const Text('Could not do schedule fetch operation');
                }

                if (state is ScheduleOperationSuccess) {
                  final schedules = state.schedules;

                  return ListView.builder(
                    itemCount: schedules.length,
                    itemBuilder: (_, idx) => ListTile(
                      title: Text(schedules.elementAt(idx).driverId),
                      subtitle: Text(schedules.elementAt(idx).managerId),
                    ),
                  );
                }

                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
