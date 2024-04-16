import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:talking/src/chat/presentation/blocs/chat/chat_bloc.dart';

import '../../../configs/colors/generic_colors.dart';
import '../../../configs/router/app_router.dart';
import '../../user/domain/entities/user_entity.dart';
import '../../user/presentation/providers/logged_user_provider.dart';
import '../../user/presentation/providers/logged_user_state.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedUser = ref.watch(loggedUserProvider.select((v) => v is LoggedUserLoaded ? v.user : User.empty));

    return AppBar(
      leadingWidth: 18,
      title: Text(
        loggedUser.name,
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
                  height: 42,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ),
                  child: Image.network(
                    // TODO(BRANDOM): Temporary image
                    'https://avatars.githubusercontent.com/u/79495707?v=4',
                  ),
                ),
                Positioned(
                  right: 1,
                  top: 1,
                  child: CircleAvatar(
                    radius: 5.5,
                    // TODO(BRANDOM): Change this, it's just for testing
                    backgroundColor:
                        context.read<ChatBloc>().state.status == ChatStatus.online ? TColors.green : TColors.red,
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
