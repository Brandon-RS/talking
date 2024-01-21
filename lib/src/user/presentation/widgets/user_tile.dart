import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../configs/colors/generic_colors.dart';
import '../../../chat/presentation/providers/chat_provider.dart';
import '../../domain/entities/user_entity.dart';

class UserTile extends ConsumerWidget {
  const UserTile({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      shape: Border(
        bottom: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      leading: CircleAvatar(
        child: Text(
          user.name.substring(0, 2).toUpperCase(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: TColors.white,
              ),
        ),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: CircleAvatar(
        backgroundColor: user.online ? TColors.green : TColors.red,
        radius: 5,
      ),
      onTap: () {
        ref.read(chatProvider.notifier).setTargetUser(user);
        ref.read(chatProvider.notifier).getUserLastChatsIfNeed();
        context.push('/chat');
      },
    );
  }
}
