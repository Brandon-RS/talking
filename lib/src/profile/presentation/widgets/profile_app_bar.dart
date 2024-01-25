import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/providers/auth_state.dart';
import '../../utils/menu_option.dart';

class ProfileAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    return AppBar(
      leadingWidth: 18,
      title: const Text('Your Profile'),
      centerTitle: false,
      actions: [
        PopupMenuButton<MenuOption>(
          icon: const Icon(Icons.more_vert),
          elevation: 1,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: MenuOption.changePassword,
              child: Text('Change Password'),
            ),
            const PopupMenuItem(
              value: MenuOption.deleteAccount,
              child: Text('Delete Account'),
            ),
            const PopupMenuItem(
              value: MenuOption.logout,
              child: Text('Logout'),
            ),
            const PopupMenuItem(
              value: MenuOption.help,
              child: Text('Help'),
            ),
            const PopupMenuItem(
              value: MenuOption.about,
              child: Text('About'),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case MenuOption.logout:
                if (auth is! AuthLoading) ref.read(authProvider.notifier).logout();
                break;
              case MenuOption.changePassword:
                context.push('/profile/change-password');
                break;
              case MenuOption.deleteAccount:
                break;
              case MenuOption.help:
                break;
              case MenuOption.about:
                break;
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
