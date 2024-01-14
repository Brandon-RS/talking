import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:talking/configs/router/app_router.dart';

import '../../../configs/colors/generic_colors.dart';
import '../../chat/presentation/providers/chat_provider.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);

    return AppBar(
      title: const Text('Talking'),
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
                    backgroundColor: chatState.isOnline ? TColors.green : TColors.red,
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
