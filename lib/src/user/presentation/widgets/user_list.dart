import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talking/src/user/presentation/blocs/users/users_bloc.dart';
import 'package:talking/src/user/presentation/widgets/user_tile.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        switch (state.status) {
          case UsersStatus.loaded:
            if (state.users.isEmpty) {
              return const Center(
                child: Text('No users found'),
              );
            }

            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (_, i) => UserTile(
                user: state.users[i],
              ),
            );
          case UsersStatus.failure:
            return Center(
              child: Text(state.error),
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
