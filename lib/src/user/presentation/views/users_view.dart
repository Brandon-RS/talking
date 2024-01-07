import 'package:flutter/material.dart';

import '../../../shared/presentation/custom_app_bar.dart';
import '../../data/models/user_model.dart';
import '../widgets/user_tile.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {},
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
