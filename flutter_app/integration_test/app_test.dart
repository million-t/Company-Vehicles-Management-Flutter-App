import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/auth/repository/user_repository.dart';

void main() {
  group('Testing App', () {
    testWidgets('To do', (tester) async {
      await tester.pumpWidget(MyApp(
        userRepository: UserRepository(),
      ));
    });
  });
}
