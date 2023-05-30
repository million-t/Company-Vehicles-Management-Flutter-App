import '../data_providers/schedule_data_provider.dart';
import '../models/schedule_model.dart';

class ScheduleRepository {
  final ScheduleDataProvider dataProvider = ScheduleDataProvider();
  ScheduleRepository();

  Future<Schedule> create(Schedule schedule, String token) async {
    return dataProvider.create(schedule, token);
  }

  Future<Schedule> update(String id, Schedule schedule, String token) async {
    return dataProvider.update(id, schedule, token);
  }

  Future<List<Schedule>> getAllToManager(String token) async {
    return dataProvider.getAllToManager(token);
  }

  Future<List<Schedule>> getAllByDriver(String token) async {
    return dataProvider.getAllByDriver(token);
  }

  Future<void> delete(String id, String token) async {
    await dataProvider.delete(id, token);
  }
}
