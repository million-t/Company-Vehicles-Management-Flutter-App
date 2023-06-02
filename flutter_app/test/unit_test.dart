import 'package:test/test.dart';
import 'package:flutter_app/auth/models/userModel.dart';
import 'package:flutter_app/vehicle/models/vehicle_model.dart';
import 'package:flutter_app/issue/models/issueModel.dart';
import 'package:flutter_app/report/models/report_model.dart';

void main() {
  group('User(Auth) class', () {
    test('Create user & user to json', () {
      final driver = User(
          name: 'foo',
          email: 'foo@email.com',
          managerId: '123',
          type: 'driver');

      final json = driver.toJson();

      expect(json['password'], '');
      expect(json['email'], 'foo@email.com');
      expect(json['type'], 'driver');
      expect(driver.email, 'foo@email.com');
      expect(driver.name, 'foo');
      expect(driver.managerId, '123');
      expect(driver.type, 'driver');
    });

    test('User from json', () {
      final json = {
        '_id': "1122",
        'name': 'foo',
        'email': 'foo@email.com',
        'manager_id': '123',
        'type': 'driver',
        'token': 'tokkeeennn',
      };
      final driver = User.fromJson(json);

      expect(driver.password, '');
      expect(driver.id, '1122');
      expect(driver.email, 'foo@email.com');
      expect(driver.token, 'tokkeeennn');
      expect(driver.managerId, '123');
      expect(driver.type, 'driver');
    });
  });

  ///
  ///
  ///
  ///
  ///

  group('Issue class', () {
    test('Create, updating issue & issue to json', () {
      final issue = Issue(
        content: 'We have some issues.',
      );

      issue.response = 'and we can handle em.';
      final json = issue.toJson();

      expect(json['status'], 'pending');
      expect(json['_id'], '');
      expect(issue.content, 'We have some issues.');
      expect(issue.response, 'and we can handle em.');
    });

    test('Issue from json', () {
      final json = {
        '_id': "_id",
        'driver_id': 'driver_id',
        'driver_name': 'driver_name',
        'manager_id': 'manager_id',
        'response': 'response',
        'content': 'content',
        'status': 'status',
      };

      final issue = Issue.fromJson(json);

      expect(issue.content, 'content');
      expect(issue.id, '_id');
      expect(issue.managerId, 'manager_id');
    });
  });

  ///
  ///
  ///
  ///
  ///

  group('Report class', () {
    test('Create report & report to json', () {
      final report = Report(
          vehicleName: 'ford',
          litres: '100',
          managerId: '123',
          price: '1100',
          distance: '2 km');

      final json = report.toJson();

      expect(json['price'], '1100');
      expect(json['distance'], '2 km');
      expect(report.litres, '100');
      expect(report.managerId, '123');
    });

    test('Report from json', () {
      final json = {
        '_id': "_id",
        'driver_id': 'driver_id',
        'driver_name': 'driver_name',
        'manager_id': 'manager_id',
        'vehicle_name': 'vehicle_name',
        'distance': 'distance',
        'price': 'price',
        'litres': 'litres',
      };

      final report = Report.fromJson(json);

      expect(report.litres, 'litres');
      expect(report.id, '_id');
      expect(report.managerId, 'manager_id');
    });
  });

  ///
  ///
  ///
  ///
  ///

  group('Vehicle class', () {
    test('Create & Update Vehicle ', () {
      final vehicle = Vehicle(
        image: 'image',
        name: 'name',
        licensePlateNumber: 'licensePlateNumber',
      );

      expect(vehicle.image, 'image');
      expect(vehicle.managerId, '');
    });

    test('vehicle from json', () {
      final json = {
        '_id': "_id",
        'license_plate_number': 'license_plate_number',
        'manager_id': 'manager_id',
        'name': 'name',
        'image': 'image',
      };

      final vehicle = Vehicle.fromJson(json);

      expect(vehicle.image, 'image');
      expect(vehicle.id, '_id');
      expect(vehicle.managerId, 'manager_id');
    });
  });
}
