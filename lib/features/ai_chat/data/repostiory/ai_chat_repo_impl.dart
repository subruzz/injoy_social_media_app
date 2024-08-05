import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/ai_chat/data/datasource/ai_chat_datasource.dart';
import 'package:social_media_app/features/ai_chat/domain/enitity/ai_chat_entity.dart';
import 'package:social_media_app/features/ai_chat/domain/repository/ai_chat_repository.dart';

class AiChatRepoImpl implements AiChatRepository {
  final AiChatDatasource _aiChatDatasource;

  AiChatRepoImpl({required AiChatDatasource aiChatDatasource})
      : _aiChatDatasource = aiChatDatasource;
  @override
  Future<Either<Failure, String>> sendAndGetChat(
      List<AiChatEntity> prevMessages, String message) async {
    try {
      final res = await _aiChatDatasource.sendAndGetChat(prevMessages, message);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }
}
