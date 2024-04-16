import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talking/configs/colors/generic_colors.dart';
import 'package:talking/src/chat/presentation/blocs/chat/chat_bloc.dart';
import 'package:talking/src/user/domain/entities/user_entity.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
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
        context.read<ChatBloc>().add(SetRecipient(user));
        context.read<ChatBloc>().add(const GetSelectedContactChatsIfNeed());
        context.push('/chat');
      },
    );
  }
}
