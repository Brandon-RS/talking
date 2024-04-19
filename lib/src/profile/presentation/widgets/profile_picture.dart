import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talking/src/profile/presentation/blocs/upload_profile_pic/upload_profile_pic_bloc.dart';

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
                child: BlocBuilder<UploadProfilePicBloc, UploadProfilePicState>(
                  builder: (context, state) {
                    if (state.image != null) {
                      return Image.file(state.image!, fit: BoxFit.cover);
                    }

                    return Image.network(
                      state.hasImage ? state.profilePic.secureUrl : 'https://avatars.githubusercontent.com/u/79495707?v=4',
                      fit: BoxFit.cover,
                    );
                  },
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
                    await FilePicker.platform.pickFiles(type: FileType.image).then((value) {
                      if (value == null) return;

                      context.read<UploadProfilePicBloc>().add(
                            SelectProfilePic(value.files.single.path!),
                          );
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
