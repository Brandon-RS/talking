import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../user/domain/entities/user_entity.dart';
import '../providers/chat_provider.dart';
import '../providers/chat_state.dart';

class ChatAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User targetUser = ref.watch(chatProvider.select((value) => value is ChatLoaded ? value.targetUser : User.empty()));

    return AppBar(
      leadingWidth: 80,
      leading: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: () {
            ref.read(chatProvider.notifier).stopChat();
            context.pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back_ios),
                Container(
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
              ],
            ),
          ),
        ),
      ),
      title: Text(
        targetUser.name,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
