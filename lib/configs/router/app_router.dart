import 'package:go_router/go_router.dart';
import 'package:talking/presentation/screens/screens.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'users',
            builder: (context, state) => const UsersScreen(),
          ),
          GoRoute(
            path: 'chat',
            builder: (context, state) => const ChatScreen(),
          ),
          GoRoute(
            path: 'profile',
            builder: (context, state) => const ChatScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/terms-and-conditions',
        builder: (context, state) => const TermsAndConditionsScreen(),
      ),
    ],
  );
}
