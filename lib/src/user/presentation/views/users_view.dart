import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/presentation/custom_app_bar.dart';
import '../../data/models/user_model.dart';
import '../providers/logged_user_provider.dart';
import '../providers/logged_user_state.dart';
import '../widgets/user_tile.dart';

class UsersView extends ConsumerWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedUser = ref.watch(loggedUserProvider);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          if (loggedUser is LoggedUserLoaded) debugPrint('✅ ${loggedUser.user.name}');
        },
        child: ListView.builder(
          itemCount: UserModel.dummyUsers.length,
          itemBuilder: (_, i) => UserTile(
            user: UserModel.dummyUsers[i],
          ),
        ),
      ),
    );
  }
}
