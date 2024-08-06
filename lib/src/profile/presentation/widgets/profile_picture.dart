import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:talking/configs/di/injector.dart';
import 'package:talking/src/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:talking/src/profile/presentation/blocs/change_profile_pic/change_profile_pic_bloc.dart';
import 'package:talking/src/user/domain/usecases/upload_profile_pic_usecase.dart';

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
                child: BlocProvider(
                  create: (context) => ChangeProfilePicBloc(
                    uploadProfilePicUsecase: sl<UploadProfilePicUsecase>(),
                  ),
                  child: const _ChangePictureButton(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ChangePictureButton extends StatelessWidget {
  const _ChangePictureButton();

  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;

    return BlocConsumer<ChangeProfilePicBloc, ChangeProfilePicState>(
      listenWhen: (previous, current) => previous.image != current.image,
      listener: (context, state) {
        if (state.image != null) {
          // TODO(BRANDOM): Check if need the user id, since backend was changed
          context.read<ChangeProfilePicBloc>().add(
                UploadProfilePic(context.read<AuthBloc>().state.user.uid),
              );
        }

        if (state.status == ChangeProfilePicStatus.success) {
          context.read<AuthBloc>().add(
                UpdateProfilePic(state.profilePic.secureUrl),
              );
        }
      },
      builder: (context, state) {
        final icon = () {
          switch (state.status) {
            case ChangeProfilePicStatus.success:
              return Icons.check;
            case ChangeProfilePicStatus.error:
              return Icons.error;
            default:
              return Icons.camera_alt_outlined;
          }
        }();

        return IconButton.filled(
          style: IconButton.styleFrom(
            disabledBackgroundColor: colorSchema.primary,
          ),
          icon: state.isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                )
              : Icon(
                  icon,
                  size: 24,
                  color: Colors.white,
                ),
          onPressed: !state.isLoading
              ? () async {
                  final pick = await FilePicker.platform.pickFiles(type: FileType.image);

                  if (pick?.files.single.path != null) {
                    final path = pick!.files.single.path!;
                    _cropFile(path).then(
                      (value) {
                        if (value == null) return;

                        context.read<ChangeProfilePicBloc>().add(
                              SelectProfilePic(value.path),
                            );
                      },
                    );
                  }
                }
              : null,
        );
      },
    );
  }

  Future<CroppedFile?> _cropFile(String path) async {
    return await ImageCropper().cropImage(
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      sourcePath: path,
      // TODO(BRANDOM): Check if can disable BottomControls in iOS,
      // otherwise remove this set here an empty list for iOS and a null for Android
      // aspectRatioPresets: [],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          hideBottomControls: true,
        ),
        IOSUiSettings(
          aspectRatioLockDimensionSwapEnabled: true,
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
        ),
      ],
    );
  }
}
