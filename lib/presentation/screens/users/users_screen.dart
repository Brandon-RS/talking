import 'package:flutter/material.dart';
import 'package:talking/presentation/screens/shared/custom_app_bar.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text('UsersScreen'),
      ),
    );
  }
}
