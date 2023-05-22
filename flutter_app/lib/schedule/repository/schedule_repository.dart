import '../data_providers/schedule_local_provider.dart';
import '../data_providers/schedule_remote_provider.dart';
import '../models/schedule.dart';
import 'package:sqflite/sqflite.dart';

class ScheduleRepository {
  final _remoteDataProvider = ScheduleRemoteDataProvider();
  // final _localDataProvider = ScheduleLocalDataProvider();

  Future<List<Schedule>> fetchAll() async {
    try {
      print('bello');
      final schedules = await _remoteDataProvider.fetchAll();
      print('bellooo');
      // await _syncLocalDatabase(schedules);
      return schedules;
    } catch (e) {
      // return _localDataProvider.getSchedules();
      return [
        Schedule(
            id: '*_*',
            driverId: '*_*',
            managerId: '*_*',
            vehicleId: '*_*',
            start: DateTime.now(),
            end: DateTime.now())
      ];
    }
  }

  // Future<void> _syncLocalDatabase(List<Schedule> schedules) async {
  //   final db = await _localDataProvider.getDb();
  //   await db.transaction((txn) async {
  //     await txn.delete(_localDataProvider.tableName);
  //     for (final schedule in schedules) {
  //       await txn.insert(_localDataProvider.tableName, schedule.toJson());
  //     }
  //   });
  // }
}


// import '../data_providers/schedule_remote_provider.dart';
// import '../models/schedule.dart';

// class ScheduleRepository {
//   final ScheduleRemoteProvider dataProvider;
//   ScheduleRepository(this.dataProvider);

//   // Future<Schedule> create(Schedule course) async {
//   //   return dataProvider.create(course);
//   // }

//   // Future<Schedule> update(int id, Schedule schedule) async {
//   //   return dataProvider.update(id, schedule);
//   // }

//   Future<List<Schedule>> fetchAll() async {
//     return dataProvider.fetchAll();
//   }

//   // Future<void> delete(int id) async {
//   //   dataProvider.delete(id);
//   // }
// }
