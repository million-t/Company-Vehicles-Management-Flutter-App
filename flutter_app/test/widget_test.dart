import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/auth/screens/LoginPage.dart';
import 'package:flutter_app/auth/screens/landing.dart';
import 'package:flutter_app/auth/repository/user_repository.dart';
import 'package:flutter_app/schedule/screens/schedules.dart';
import 'package:flutter_app/schedule/screens/schedule_form.dart';
import 'package:flutter_app/issue/screens/issue.dart';
import 'package:flutter_app/vehicle/screens/vehicles.dart';
import 'package:flutter_app/vehicle/screens/vehiclesCreate.dart';
import 'package:flutter_app/settings/driverSettings.dart';
import 'package:flutter_app/settings/driversPage.dart';

void main() {
  // landing page
  testWidgets('Find Landing page text >> VeValet', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: WelcomePage()));
    final textFinder = find.text("VeValet");
    final nonExistingtextFinder = find.text('Welcome!');

    expect(textFinder, findsOneWidget);
    expect(nonExistingtextFinder, findsNothing);
  });

//

  // login page
  testWidgets('Find Fields', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: LoginPage(userRepository: UserRepository())));
    final formFinder = find.byType(TextField);
    final logoutFinder = find.text('logout');

    expect(formFinder, findsWidgets);
    expect(logoutFinder, findsNothing);
  });

  testWidgets('Find Buttons', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: LoginPage(userRepository: UserRepository())));
    final elevatedButtonFinder = find.byType(ElevatedButton);
    final txtButtonFinder = find.byType(TextButton);

    expect(elevatedButtonFinder, findsOneWidget);
    expect(txtButtonFinder, findsOneWidget);
  });

//

  // schedule page
  testWidgets('Schedule Display Control Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ScheduleScreen()));
    final floatingButtonFinder = find.byType(FloatingActionButton);
    final visibilityFinder = find.byType(Visibility);

    expect(floatingButtonFinder, findsNothing);
    expect(visibilityFinder, findsOneWidget);
  });

  // testWidgets('Schedule Create Fields Test', (WidgetTester tester) async {
  //   await tester.pumpWidget(MaterialApp(home: ManagerSchedule()));
  //   final dropDownFinder = find.byType(DropdownButtonFormField);
  //   final textFormFinder = find.byType(TextFormField);
  //   final submitFinder = find.text('Submit');

  //   expect(dropDownFinder, findsWidgets);
  //   expect(textFormFinder, findsWidgets);
  //   expect(submitFinder, findsOneWidget);
  // });

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///

// Issue Screen
  testWidgets('Issue Display Control Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: IssueScreen()));
    final floatingButtonFinder = find.byType(FloatingActionButton);
    final visibilityFinder = find.byType(Visibility);

    expect(floatingButtonFinder, findsNothing);
    expect(visibilityFinder, findsOneWidget);
  });

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///

// Vehicles Screen
  testWidgets('Vehicles Page working', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: VehicleScreen()));
    final floatingButtonFinder = find.byType(FloatingActionButton);
    final scaffoldFinder = find.byType(Scaffold);

    expect(floatingButtonFinder, findsOneWidget);
    expect(scaffoldFinder, findsOneWidget);
  });

  testWidgets('Create Vehicle Page working', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: VehicleCreateUpdate()));
    final buttonFinder = find.byType(ElevatedButton);
    final textFieldFinder = find.byType(TextField);
    final scaffoldFinder = find.byType(Scaffold);
    final submitFinder = find.text("Submit");

    expect(buttonFinder, findsWidgets);
    expect(textFieldFinder, findsWidgets);
    expect(scaffoldFinder, findsOneWidget);
    expect(submitFinder, findsOneWidget);
  });

  ///
  ///

  //settings page
  testWidgets('Settings Page working', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Settings()));
    final cardFinder = find.byType(Card);
    final visibilityFinder = find.byType(Visibility);

    final textFinder = find.text("Profile");

    expect(cardFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
    expect(visibilityFinder, findsWidgets);
  });

  ///
  ///
  ///

// drivers list page
  testWidgets('drivers list Page working', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: VehicleScreen()));

    final scaffoldFinder = find.byType(Scaffold);
    final listFinder = find.byType(ListView);

    expect(scaffoldFinder, findsOneWidget);

    expect(listFinder, findsNothing);
  });
}
