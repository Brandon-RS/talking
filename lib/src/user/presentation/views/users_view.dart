import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talking/src/shared/presentation/custom_app_bar.dart';
import 'package:talking/src/user/presentation/blocs/users/users_bloc.dart';
import 'package:talking/src/user/presentation/widgets/user_list.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocListener<UsersBloc, UsersState>(
        listener: (context, state) {
          switch (state.status) {
            case UsersStatus.failure:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
              break;
            default:
              break;
          }
        },
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<UsersBloc>().add(const GetUsers());
          },
          child: context.watch<UsersBloc>().state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : const UserList(),
        ),
      ),
    );
  }
}
