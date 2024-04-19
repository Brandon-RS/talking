import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talking/src/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:talking/src/profile/presentation/widgets/profile_app_bar.dart';
import 'package:talking/src/profile/presentation/widgets/profile_section.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
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
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: IconButton.filled(
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        size: 24,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles(type: FileType.image);
                        if (result != null) {
                          setState(() {
                            _image = File(result.files.single.path!);
                          });

                          final formData = FormData.fromMap(
                            {'file': await MultipartFile.fromFile(_image!.path)},
                          );

                          final response = await Dio().post(
                            'https://api.cloudinary.com/v1_1/brandon-rs/image/upload',
                            queryParameters: {
                              'upload_preset': 'profile-pics',
                              'public_id': 'custom-name',
                            },
                            data: formData,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 160,
              width: 160,
              child: _image != null ? Image.file(_image!) : const SizedBox.shrink(),
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
    );
  }
}
