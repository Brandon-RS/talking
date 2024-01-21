import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/providers/auth_state.dart';
import '../../../auth/presentation/widgets/logo.dart';
import '../../../chat/presentation/providers/chat_provider.dart';
import '../../../user/presentation/providers/logged_user_provider.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authProvider.notifier).renewToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (prev, next) {
      if (next is LoggedIn) {
        context.replace('/users');

        ref.read(loggedUserProvider.notifier).init(
              token: next.token,
              user: next.user,
            );

        ref.read(chatProvider.notifier).connect();
      } else if (next is LoggedOut || next is AuthError) {
        context.replace('/login');
      }
    });

    return const Scaffold(
      body: Center(
        child: Logo(),
      ),
    );
  }
}
