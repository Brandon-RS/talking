import '../../../../core/utils/typedefs.dart';
import '../../data/models/message_model.dart';

abstract class ChatsRepo {
  const ChatsRepo();

  ResultFuture<List<MessageModel>> getChats(String targetUserId);
}
