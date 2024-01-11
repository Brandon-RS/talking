import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/providers/auth_state.dart';
import '../../../shared/presentation/custom_app_bar.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    ref.listen<AuthState>(
      authProvider,
      (prev, next) {
        if (next is LoggedOut) {
          context.replace('/login');
          ref.invalidate(authProvider);
        }
      },
    );

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: FilledButton(
          onPressed: auth is! AuthLoading ? () => ref.read(authProvider.notifier).logout() : null,
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
