import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/presentation/custom_app_bar.dart';
import '../providers/logged_user_provider.dart';
import '../providers/logged_user_state.dart';
import '../providers/users_provider.dart';
import '../providers/users_state.dart';
import '../widgets/user_tile.dart';

class UsersView extends ConsumerWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedUser = ref.watch(loggedUserProvider);
    final users = ref.watch(usersProvider);
    final usersList = ref.watch(usersProvider.select((value) => users is UsersLoaded ? users.users : []));

    if (users is UsersInitial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(usersProvider.notifier).getUsersIfNeed();
      });
    }

    ref.listen<UsersState>(usersProvider, (prev, next) {
      if (next is UsersError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    return Scaffold(
      appBar: const CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          if (loggedUser is LoggedUserLoaded) debugPrint('✅ ${loggedUser.user.name}');
        },
        child: ListView.builder(
          itemCount: usersList.length,
          itemBuilder: (_, i) => UserTile(
            user: usersList[i],
          ),
        ),
      ),
    );
  }
}
