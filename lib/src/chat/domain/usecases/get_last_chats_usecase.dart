import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedefs.dart';
import '../entities/message_entity.dart';
import '../repos/chats_repo.dart';

@injectable
class GetLastChatsUsecase implements Usecase<List<Message>, String> {
  const GetLastChatsUsecase(this._repo);

  final ChatsRepo _repo;

  @override
  ResultFuture<List<Message>> call(String targetUserId) async {
    try {
      if (targetUserId.trim().isEmpty) {
        return const Left(
          AppFailure(
            'Target user id must not be empty.',
          ),
        );
      }

      final result = await _repo.getChats(targetUserId);

      return result.fold(
        (failure) => Left(failure),
        (chats) => Right(Message.fromModelList(chats)),
      );
    } catch (e) {
      return const Left(
        AppFailure(
          'Error while trying to get chats. Please, try again later.',
        ),
      );
    }
  }
}
