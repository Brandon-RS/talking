import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/presentation/custom_app_bar.dart';
import '../providers/users_provider.dart';
import '../providers/users_state.dart';
import '../widgets/user_list.dart';

class UsersView extends ConsumerWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersProvider);

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
          ref.read(usersProvider.notifier).getALlUsers();
        },
        child: users is! UsersLoading
            ? const UserList()
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
