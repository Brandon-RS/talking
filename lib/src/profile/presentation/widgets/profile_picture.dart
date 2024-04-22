import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talking/src/auth/presentation/blocs/auth/auth_bloc.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Stack(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                height: 160,
                width: 160,
                decoration: ShapeDecoration(
                  shape: CircleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline.withOpacity(.7),
                      width: .6,
                    ),
                  ),
                ),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) => state.hasImage
                      ? Image.network(
                          state.user.profileImage!,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.person, size: 80),
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
                  onPressed: () {
                    FilePicker.platform.pickFiles(type: FileType.image).then((value) {
                      if (value == null) return;
                      context.push('/profile/change-picture', extra: value.files.single.path);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
