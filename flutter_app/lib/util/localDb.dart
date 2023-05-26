import 'package:sqflite/sqflite.dart';
// import '../models/schedule.dart';
import 'package:path/path.dart';

class ScheduleLocalDataProvider {
  String tableName = 'schedules';

  Future<Database> getDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'schedule.db');
    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY,
          driverName TEXT,
          managerName TEXT
        )
      ''');
    });
  }

  // Future<List<Schedule>> getSchedules() async {
  //   final db = await getDb();
  //   final data = await db.query(tableName);
  //   return data.map((json) => Schedule.fromJson(json)).toList();
  // }

  // _getDb() {}
}
