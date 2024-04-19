import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talking/configs/di/injector.dart';
import 'package:talking/src/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:talking/src/profile/presentation/blocs/upload_profile_pic/upload_profile_pic_bloc.dart';
import 'package:talking/src/profile/presentation/widgets/profile_app_bar.dart';
import 'package:talking/src/profile/presentation/widgets/profile_picture.dart';
import 'package:talking/src/profile/presentation/widgets/profile_section.dart';
import 'package:talking/src/user/domain/usecases/upload_profile_pic_usecase.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: BlocProvider(
          create: (context) => UploadProfilePicBloc(
            uploadProfilePicUsecase: sl<UploadProfilePicUsecase>(),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProfilePicture(),
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
              const Positioned(
                left: 0,
                right: 0,
                bottom: 30,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _SaveChangesButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SaveChangesButton extends StatelessWidget {
  const _SaveChangesButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadProfilePicBloc, UploadProfilePicState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (!state.isLoading && state.image != null) {
          return OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              context.read<UploadProfilePicBloc>().add(
                    UploadProfilePic(context.read<AuthBloc>().state.user.uid),
                  );
            },
            icon: const Icon(Icons.save_outlined, size: 20),
            label: const Text('Save'),
          );
        }

        if (state.isLoading) {
          return const LinearProgressIndicator();
        }

        return const SizedBox.shrink();
      },
    );
  }
}
