import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talking/configs/di/injector.dart';
import 'package:talking/src/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:talking/src/profile/presentation/blocs/change_profile_pic/change_profile_pic_bloc.dart';
import 'package:talking/src/user/domain/usecases/upload_profile_pic_usecase.dart';

class ChangePictureView extends StatelessWidget {
  const ChangePictureView({
    super.key,
    this.selectedImagePath,
  });

  final String? selectedImagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ChangeProfilePicBloc(
            uploadProfilePicUsecase: sl<UploadProfilePicUsecase>(),
          ),
          child: _ImageViewer(selectedImagePath: selectedImagePath),
        ),
      ),
    );
  }
}

class _ImageViewer extends StatefulWidget {
  const _ImageViewer({this.selectedImagePath});
  final String? selectedImagePath;

  @override
  State<_ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<_ImageViewer> {
  @override
  void initState() {
    super.initState();
    if (widget.selectedImagePath != null) {
      context.read<ChangeProfilePicBloc>().add(
            SelectProfilePic(widget.selectedImagePath!),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        BlocBuilder<ChangeProfilePicBloc, ChangeProfilePicState>(
          builder: (context, state) {
            if (state.image == null) {
              // TODO(BRANDOM): Add a button to select an image
              return const Center(child: CircularProgressIndicator());
            }

            return Center(
              child: InteractiveViewer(
                  child: Image.file(
                state.image!,
                fit: BoxFit.cover,
              )),
            );
          },
        ),
        Positioned(
          bottom: 20,
          left: size.width * .25,
          child: IconButton.outlined(
            icon: const Icon(Icons.close),
            onPressed: () => context.pop(),
          ),
        ),
        Positioned(
          bottom: 20,
          right: size.width * .25,
          child: BlocListener<ChangeProfilePicBloc, ChangeProfilePicState>(
            listener: (context, state) {
              if (state.status == ChangeProfilePicStatus.success) {
                // TODO(BRANDOM): When backend is ready change the image url in the auth state
                context.pop();
              }
            },
            child: BlocBuilder<ChangeProfilePicBloc, ChangeProfilePicState>(
              builder: (context, state) => IconButton.outlined(
                icon: state.isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(),
                      )
                    : const Icon(Icons.check),
                onPressed: !state.isLoading
                    ? () => context.read<ChangeProfilePicBloc>().add(
                          UploadProfilePic(context.read<AuthBloc>().state.user.uid),
                        )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
