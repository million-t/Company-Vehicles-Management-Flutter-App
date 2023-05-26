import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../auth/repository/user_repository.dart';
import '../auth/data_providers/remote_user_data_provider.dart';
import '../auth/screens/LoginPage.dart';
import '../issue/screens/issuePage.dart';
import '../settings/driverSettings.dart';
import '../schedule/screens/driverSchedulePage.dart';
// import 'package:go_router_sample/pages/home.dart';
// import 'package:go_router_sample/pages/profile.dart';
import 'appRouteConstants.dart';

class AppRouter {
  static GoRouter returnRouter(String? token) {
    GoRouter router = GoRouter(
      routes: [
        GoRoute(
          name: AppRouteConstants.landing,
          path: '/',
          pageBuilder: (context, state) {
            return MaterialPage(child: SchedulesList());
          },
        ),
        GoRoute(
          name: AppRouteConstants.login,
          path: '/login',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: LoginPage(
              userRepository: UserRepository(),
            ));
          },
        ),
        GoRoute(
          name: AppRouteConstants.driverIssue,
          path: '/driver/issue',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: IssueRequest(
                    // userid: state.params['userid']!,
                    // username: state.params['username']!,
                    ));
          },
        ),
        GoRoute(
          name: AppRouteConstants.driverSetting,
          path: '/driver/setting',
          pageBuilder: (context, state) {
            return MaterialPage(child: Settings());
          },
        )
      ],
      // errorPageBuilder: (context, state) {
      //   return MaterialPage(child: ErrorPage());
      // },
      redirect: (context, state) {
        if (token == null || token == '') {
          return context.namedLocation(AppRouteConstants.login);
        } else {
          return null;
        }
      },
    );
    return router;
  }
}
