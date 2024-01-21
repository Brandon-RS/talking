import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/dio_error_handler.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/repos/chats_repo.dart';
import '../datasources/chats_remote_data_src.dart';
import '../models/message_model.dart';

@Injectable(as: ChatsRepo)
class ChatsRepoImpl implements ChatsRepo {
  const ChatsRepoImpl(this._src);

  final ChatsRemoteDataSrc _src;

  @override
  ResultFuture<List<MessageModel>> getChats(String targetUserId) async {
    try {
      final result = await _src.getChats(targetUserId);
      return Right(result);
    } catch (e) {
      final failure = ErrorHandler.handle(e, defaultMessage: 'Error getting chats');

      return Left(failure);
    }
  }
}
