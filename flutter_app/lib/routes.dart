import './schedule/screens/driverSchedulePage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './report/screens/driverReport.dart';
import './auth/screens/LoginPage.dart';
import './auth/repository/user_repository.dart';
import './settings/driverSettings.dart';
import './report/screens/createUpdateReport.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

// the one and only GoRouter instance
final goRouter = GoRouter(
  initialLocation: '/schedule',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      pageBuilder: (context, state) => NoTransitionPage(
        child: LoginPage(userRepository: UserRepository()),
        // const RootScreen(label: 'A', detailsPath: '/schedule/create'),
      ),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithBottomNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/schedule',
          name: 'schedule',
          pageBuilder: (context, state) => NoTransitionPage(
            child: SchedulesList(),
            // const RootScreen(label: 'A', detailsPath: '/schedule/create'),
          ),
          // routes: [
          //   GoRoute(
          //     path: 'report',
          //     builder: (context, state) => const DetailsScreen(label: 'A'),
          //   ),
          // ],
        ),
        GoRoute(
          path: '/report',
          name: 'report',
          pageBuilder: (context, state) => NoTransitionPage(
            child: ReportScreen(),
          ),
          routes: [
            GoRoute(
              path: 'details',
              name: 'createUpdate',
              builder: (context, state) => ReportCreateUpdate(isNew: true),
            ),
          ],
        ),
        GoRoute(
          path: '/issues',
          name: 'issues',
          pageBuilder: (context, state) => NoTransitionPage(
            child: SchedulesList(),
            // const RootScreen(label: 'A', detailsPath: '/schedule/create'),
          ),
          // routes: [
          //   GoRoute(
          //     path: 'report',
          //     builder: (context, state) => const DetailsScreen(label: 'A'),
          //   ),
          // ],
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          pageBuilder: (context, state) => NoTransitionPage(
            child: Settings(),
            // const RootScreen(label: 'A', detailsPath: '/schedule/create'),
          ),
          // routes: [
          //   GoRoute(
          //     path: 'report',
          //     builder: (context, state) => const DetailsScreen(label: 'A'),
          //   ),
          // ],
        )
      ],
    ),
  ],
);
const tabs = [
  ScaffoldWithNavBarTabItem(
    initialLocation: '/schedule',
    icon: Icon(Icons.home),
    label: 'Schedule',
  ),
  ScaffoldWithNavBarTabItem(
    initialLocation: '/report',
    icon: Icon(Icons.settings),
    label: 'Report',
  ),
  ScaffoldWithNavBarTabItem(
    initialLocation: '/issues',
    icon: Icon(Icons.settings),
    label: 'issues',
  ),
  ScaffoldWithNavBarTabItem(
    initialLocation: '/Settings',
    icon: Icon(Icons.settings),
    label: 'Settings',
  )
];

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  // getter that computes the current index from the current location,
  // using the helper method below
  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index =
        tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  // callback used to navigate to the desired tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff222831),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        backgroundColor: Color(0xff222831),
        currentIndex: _currentIndex,
        items: tabs,
        onTap: (tabIndex) {
          if (tabIndex != _currentIndex) {
            // go to the initial location of the selected tab (by index)
            context.go(tabs[tabIndex].initialLocation);
            // context.go(tabs[tabIndex].initialLocation);
          }
        },
      ),
    );
  }
}

/// Representation of a tab item in the ScaffoldWithBottomNavBar
class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  const ScaffoldWithNavBarTabItem(
      {required this.initialLocation,
      required Widget icon,
      String? label,
      Color color = const Color.fromARGB(255, 65, 76, 92)})
      : super(icon: icon, label: label, backgroundColor: color);

  /// The initial location/path
  final String initialLocation;
}
