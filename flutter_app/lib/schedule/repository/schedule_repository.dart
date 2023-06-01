import '../data_providers/schedule_data_provider.dart';
import '../models/schedule_model.dart';
import '../../util/local_provider.dart';

class ScheduleRepository {
  final ScheduleDataProvider dataProvider = ScheduleDataProvider();
  LocalDb localDb = LocalDb();
  ScheduleRepository();

  Future<Schedule> create(Schedule schedule, String token) async {
    return dataProvider.create(schedule, token);
  }

  Future<Schedule> update(String id, Schedule schedule, String token) async {
    return dataProvider.update(id, schedule, token);
  }

  Future<List<Schedule>> getAllToManager(String token) async {
    try {
      final remote = await dataProvider.getAllToManager(token);
      await localDb
          .saveSchedules(remote.map((schedule) => schedule.toJson()).toList());
      return remote;
    } catch (_) {
      // return [];
      final localData = await localDb.getSchedules();
      return localData;
    }
  }

  Future<List<Schedule>> getAllByDriver(String token) async {
    try {
      final remote = await dataProvider.getAllByDriver(token);
      await localDb
          .saveSchedules(remote.map((schedule) => schedule.toJson()).toList());
      return remote;
    } catch (_) {
      // return [];
      final localData = await localDb.getSchedules();
      return localData;
    }
  }

  Future<void> delete(String id, String token) async {
    await dataProvider.delete(id, token);
  }
}
