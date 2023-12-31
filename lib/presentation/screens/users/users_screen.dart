import 'package:flutter/material.dart';
import 'package:talking/data/models/user_model.dart';
import 'package:talking/presentation/screens/shared/custom_app_bar.dart';

import 'widgets/user.widgets.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

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
