import 'package:go_router/go_router.dart';
import 'package:phiny_gui/features/profile/presentation/views/profile_setup_page.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: "/", builder: (context, state) => ProfileSetupPage()),
    ],
  );
}
