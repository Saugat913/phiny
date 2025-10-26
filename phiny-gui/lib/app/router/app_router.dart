import 'package:go_router/go_router.dart';
import 'package:phiny_gui/app/layout/dashboard_layout.dart';
import 'package:phiny_gui/features/call/presentation/views/call_history_page.dart';
import 'package:phiny_gui/features/call/presentation/views/dialpad_page.dart';
import 'package:phiny_gui/features/profile/presentation/views/profile_page.dart';
import 'package:phiny_gui/features/profile/presentation/views/profile_setup_page.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: "/", builder: (context, state) => ProfileSetupPage()),
      StatefulShellRoute.indexedStack(
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/dialpad",
                builder: (context, state) {
                  return DialPadPage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/callhistory",
                builder: (context, state) {
                  return CallHistoryPage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/profile",
                builder: (context, state) {
                  return ProfilePage();
                },
              ),
            ],
          ),
        ],
        builder: (context, state, shell) {
          return DashBoardLayout(
            currentActiveIndex: shell.currentIndex,
            currentPage: shell,
          );
        },
      ),
    ],
  );
}
