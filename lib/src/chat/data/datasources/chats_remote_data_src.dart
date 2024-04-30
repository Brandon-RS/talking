import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../configs/api/api.dart';
import '../models/message_model.dart';

abstract class ChatsRemoteDataSrc {
  const ChatsRemoteDataSrc();

  Future<List<MessageModel>> getChats(String targetUserId);
}

@Injectable(as: ChatsRemoteDataSrc)
class ChatsRemoteDataSrcImpl implements ChatsRemoteDataSrc {
  const ChatsRemoteDataSrcImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<MessageModel>> getChats(String targetUserId) async {
    final response = await _dio.get(Api.chats(targetUserId));

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'];
      return data.map((e) => MessageModel.fromJson(e)).toList();
    } else {
      throw Exception('Error on get chats');
    }
  }
}
