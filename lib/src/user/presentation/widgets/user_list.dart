import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/users_provider.dart';
import '../providers/users_state.dart';
import 'user_tile.dart';

class UserList extends ConsumerWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersList = ref.watch(usersProvider.select((value) => value is UsersLoaded ? value.users : []));

    return usersList.isNotEmpty
        ? ListView.builder(
            itemCount: usersList.length,
            itemBuilder: (_, i) => UserTile(
              user: usersList[i],
            ),
          )
        : const Center(
            child: Text('No users found'),
          );
  }
}
