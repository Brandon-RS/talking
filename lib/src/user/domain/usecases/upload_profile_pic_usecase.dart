import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:talking/core/errors/failure.dart';
import 'package:talking/core/usecases/usecase.dart';
import 'package:talking/core/utils/typedefs.dart';
import 'package:talking/src/user/domain/entities/profile_pic_entity.dart';
import 'package:talking/src/user/domain/repos/user_repo.dart';

@injectable
class UploadProfilePicUsecase implements Usecase<ProfilePicEntity, (String, String)> {
  const UploadProfilePicUsecase(this._repo);

  final UserRepo _repo;

  @override
  ResultFuture<ProfilePicEntity> call((String, String) user) async {
    try {
      final (path, userUid) = user;

      if (path.isEmpty || userUid.isEmpty) {
        return const Left(
          AppFailure(
            'Please, select an image to upload.',
          ),
        );
      }

      final result = await _repo.uploadProfilePic(
        path: path,
        userUid: userUid,
      );

      return result.fold(
        (failure) => Left(failure),
        (model) => Right(ProfilePicEntity.fromModel(model)),
      );
    } catch (e) {
      return const Left(
        AppFailure(
          'Error while trying to upload profile picture. Please, try again.',
        ),
      );
    }
  }
}
