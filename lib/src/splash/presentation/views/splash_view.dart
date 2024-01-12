import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/providers/auth_state.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (prev, next) {
      if (next is LoggedIn) {
        // TODO(BRANDOM): Initialize the logged user provider
        context.replace('/users');
      } else if (next is LoggedOut) {
        context.replace('/login');
      }
    });

    ref.read(authProvider.notifier).renewToken();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash'),
      ),
      body: const Center(
        child: Text('SplashScreen'),
      ),
    );
  }
}
