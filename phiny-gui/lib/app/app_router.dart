import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phiny_gui/app/layout/dashboard_layout.dart';
import 'package:phiny_gui/features/call/presentation/views/call_history_page.dart';
import 'package:phiny_gui/features/call/presentation/views/call_page.dart';
import 'package:phiny_gui/features/call/presentation/views/dialpad_page.dart';
import 'package:phiny_gui/features/profile/presentation/providers/profile_notifier.dart';
import 'package:phiny_gui/features/profile/presentation/views/edit_profile_page.dart';
import 'package:phiny_gui/features/profile/presentation/views/profile_page.dart';
import 'package:phiny_gui/features/profile/presentation/views/profile_setup_page.dart';

class AppRouter {
  static void redirect(BuildContext context, String path) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.go(path);
    });
  }

  static final router = Provider((ref) {
    return GoRouter(
      redirect: (context, state) {
        final displayName = ref.read(displayNameProvider);
        if (displayName == null) {
          return "/";
        }
        return null;
      },
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
                GoRoute(
                  path: "/calling",
                  builder: (context, state) {
                    final params = state.uri.queryParameters;
                    final name = params["name"] ?? "Unknown";
                    final nodeId = params["nodeId"] ?? "";
                    return CallingPage(targetNodeId: nodeId, targetName: name);
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
                GoRoute(
                  path: "/editprofile",
                  builder: (context, state) {
                    return EditProfilePage();
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
  });
}
