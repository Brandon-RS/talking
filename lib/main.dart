import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talking/configs/di/injector.dart';
import 'package:talking/configs/router/app_router.dart';
import 'package:talking/configs/storage/storage_manager.dart';
import 'package:talking/configs/theme/app_theme.dart';
import 'package:talking/src/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:talking/src/chat/domain/usecases/get_last_chats_usecase.dart';
import 'package:talking/src/chat/presentation/blocs/chat/chat_bloc.dart';
import 'package:talking/src/user/domain/usecases/get_all_users_usecase.dart';
import 'package:talking/src/user/presentation/blocs/users/users_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initApp();

  runApp(
    const ProviderScope(
      child: TalkingApp(),
    ),
  );
}

Future<void> initApp() async {
  configureDependencies();
  await sl<StorageManager>().init();
}

class TalkingApp extends StatelessWidget {
  const TalkingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => UsersBloc(getAllUsersUsecase: sl<GetAllUsersUsecase>())),
        BlocProvider(
          create: (_) => ChatBloc(
            getLastChatsUsecase: sl<GetLastChatsUsecase>(),
            storageManager: sl<StorageManager>(),
          ),
        ),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Talking',
      routerConfig: AppRouter.router,
      theme: AppTheme.light,
      builder: (context, child) => BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          switch (state.status) {
            case AuthStatus.authenticated:
              AppRouter.router.replace('/users');
              break;
            case AuthStatus.unauthenticated:
              AppRouter.router.replace('/login');
              break;
            case AuthStatus.unknown:
              break;
          }
        },
        child: child,
      ),
    );
  }
}
