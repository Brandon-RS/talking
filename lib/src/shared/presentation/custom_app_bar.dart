import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talking/configs/colors/generic_colors.dart';
import 'package:talking/configs/router/app_router.dart';
import 'package:talking/src/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:talking/src/chat/presentation/blocs/chat/chat_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 18,
      title: BlocBuilder<AuthBloc, AuthState>(
        builder: (_, state) => Text(state.user.name),
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: () {
              if (AppRouter.location != '/profile') context.push('/profile');
            },
            child: Stack(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  height: 42,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) => state.hasImage
                        ? Image.network(state.user.profileImage!, fit: BoxFit.cover)
                        : const Icon(Icons.person, size: 80),
                  ),
                ),
                Positioned(
                  right: 1,
                  top: 1,
                  child: BlocBuilder<ChatBloc, ChatState>(
                    builder: (_, state) => CircleAvatar(
                      radius: 5.5,
                      backgroundColor: state.isOnline ? TColors.green : TColors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
