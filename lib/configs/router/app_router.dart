import 'package:go_router/go_router.dart';

import '../../src/auth/presentation/views/login_view.dart';
import '../../src/chat/presentation/views/chat_view.dart';
import '../../src/home/presentation/views/home_View.dart';
import '../../src/profile/presentation/views/profile_view.dart';
import '../../src/splash/presentation/views/splash_view.dart';
import '../../src/terms_and_conditions/presentation/views/terms_and_conditions_view.dart';
import '../../src/user/presentation/views/register_view.dart';
import '../../src/user/presentation/views/users_view.dart';
import '../di/injector.dart';
import '../storage/storage_manager.dart';

class AppRouter {
  static final _storageManager = sl<StorageManager>();

  static final router = GoRouter(
    initialLocation: _storageManager.currentToken != null ? '/users' : '/login',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeView(),
        routes: [
          GoRoute(
            path: 'chat',
            builder: (context, state) => const ChatView(),
          ),
          GoRoute(
            path: 'profile',
            builder: (context, state) => const ProfileView(),
          ),
        ],
      ),
      GoRoute(
        path: '/users',
        builder: (context, state) => const UsersView(),
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: '/terms-and-conditions',
        builder: (context, state) => const TermsAndConditionsView(),
      ),
    ],
  );

  static String get location {
    final lastMatch = router.routerDelegate.currentConfiguration.last;
    final matchList = lastMatch is ImperativeRouteMatch ? lastMatch.matches : router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
