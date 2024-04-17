import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talking/configs/colors/generic_colors.dart';
import 'package:talking/src/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:talking/src/auth/presentation/widgets/logo.dart';
import 'package:talking/src/profile/utils/menu_option.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // final auth = ref.watch(authProvider);

    return AppBar(
      leadingWidth: 18,
      title: const Text('Your Profile'),
      centerTitle: false,
      actions: [
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) => PopupMenuButton<MenuOption>(
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
                  if (!state.isLoading) context.read<AuthBloc>().add(const Logout());
                  break;
                case MenuOption.changePassword:
                  context.push('/profile/change-password');
                  break;
                case MenuOption.deleteAccount:
                  _showDeleteAccountDialog(
                    context,
                    () {
                      if (!state.isLoading) context.read<AuthBloc>().add(const DeleteAccount());
                    },
                  );
                  break;
                case MenuOption.help:
                  break;
                case MenuOption.about:
                  _showAboutDialog(context);
                  break;
              }
            },
          ),
        ),
      ],
    );
  }

  void _showDeleteAccountDialog(BuildContext context, VoidCallback onDeleteAccount) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: TColors.lightRed,
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.all(16),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: TColors.white,
                  size: 48,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Are you sure you want to delete your account permanently?',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 14,
                    ),
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  text:
                      'This action cannot be undone and all your data will be lost. Your messages*, contacts, and all other data will be permanently deleted.\n\n',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text:
                          '* All messages will be deleted but may still be available up to 6 hours on the devices of the people you have been chatting with.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: TColors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary.withOpacity(.7),
                        ),
                      ),
                    ),
                    onPressed: onDeleteAccount,
                    child: const Text('Delete'),
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      foregroundColor: TColors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => context.pop(),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Logo(
              text: 'Talking',
              version: 'v1.0.0',
            ),
            const SizedBox(height: 16),
            Text(
              'Talking is a simple chat app built with Flutter and Express.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () => context.pop(),
                child: const Text('Close'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
