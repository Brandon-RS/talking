import 'package:go_router/go_router.dart';

import '../../src/auth/presentation/views/login_view.dart';
import '../../src/chat/presentation/views/chat_view.dart';
import '../../src/home/presentation/views/home_View.dart';
import '../../src/splash/presentation/views/splash_view.dart';
import '../../src/terms_and_conditions/presentation/views/terms_and_conditions_view.dart';
import '../../src/user/presentation/views/register_view.dart';
import '../../src/user/presentation/views/users_view.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
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
            builder: (context, state) => const ChatView(),
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
}
