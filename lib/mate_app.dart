import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talking/configs/router/app_router.dart';
import 'package:talking/configs/theme/app_theme.dart';
import 'package:talking/src/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:talking/src/chat/presentation/blocs/chat/chat_bloc.dart';
import 'package:talking/src/user/presentation/blocs/users/users_bloc.dart';

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
              context.read<ChatBloc>().connect();
              context.read<UsersBloc>().add(const GetUsersIfNeed());
              break;
            case AuthStatus.loading:
              break;
            default:
              AppRouter.replaceAndRemoveUntil('/login');
              break;
          }
        },
        child: child,
      ),
    );
  }
}
