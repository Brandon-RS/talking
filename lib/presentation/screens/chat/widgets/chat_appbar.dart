import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 80,
      leading: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: () => context.pop(),
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
        'Testing name',
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
