import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talking/src/user/presentation/providers/users_provider.dart';

import '../../../../configs/router/app_router.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/providers/auth_state.dart';
import '../../../chat/presentation/providers/chat_provider.dart';
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
          AppRouter.replaceAndRemoveUntil('/login');
          ref.invalidate(authProvider);
          ref.read(chatProvider.notifier).disconnect();
          ref.read(usersProvider.notifier).reset();
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
