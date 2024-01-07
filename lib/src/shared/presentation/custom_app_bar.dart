import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Talking'),
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
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
              const Positioned(
                right: 1,
                top: 1,
                child: CircleAvatar(
                  radius: 5.5,
                  // TODO(BRANDOM): Change color based on connection status
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
