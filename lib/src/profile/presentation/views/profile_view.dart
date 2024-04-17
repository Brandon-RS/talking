import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talking/src/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:talking/src/chat/presentation/blocs/chat/chat_bloc.dart';
import 'package:talking/src/profile/presentation/widgets/profile_app_bar.dart';
import 'package:talking/src/profile/presentation/widgets/profile_section.dart';
import 'package:talking/src/user/presentation/blocs/users/users_bloc.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO(BRANDOM): Check if better to do this logic on the main.dart
        if (state.status == AuthStatus.unauthenticated) {
          // TODO(BRANDOM): Check if need to reset the AuthBloc here
          context.read<ChatBloc>().add(const Disconnect());
          // TODO(BRANDOM): Check this "initial" logic
          context.read<UsersBloc>().add(const UsersInitial());
          // ref.read(loggedUserProvider.notifier).reset();
        }
      },
      child: Scaffold(
        appBar: const ProfileAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 160,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline.withOpacity(.7),
                        width: .6,
                      ),
                    ),
                  ),
                  child: Image.network(
                    // TODO(BRANDOM): Temporary image
                    'https://avatars.githubusercontent.com/u/79495707?v=4',
                  ),
                ),
              ),
              const SizedBox(height: 30),
              BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) => previous.user.name != current.user.name,
                builder: (context, state) => ProfileSection(
                  title: 'Name',
                  value: state.user.name,
                  icon: Icons.person_outline,
                ),
              ),
              const SizedBox(height: 15),
              BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) => previous.user.email != current.user.email,
                builder: (context, state) => ProfileSection(
                  title: 'Email',
                  value: state.user.email,
                  icon: Icons.email_outlined,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
