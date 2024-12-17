import 'package:wori_app/core/features/data/datasources/message/messages_remote_data_source.dart';
import 'package:wori_app/core/features/domain/entities/message/daily_question_entity.dart';
import 'package:wori_app/core/features/domain/entities/message/message_entity.dart';
import 'package:wori_app/core/features/domain/repositories/message/messages_repository.dart';

class MessageRepositoryImpl implements MessagesRepository {
  final MessagesRemoteDataSource messagesRemoteDataSource;

  MessageRepositoryImpl({required this.messagesRemoteDataSource});

  @override
  Future<List<MessageEntity>> fetchMessages(String conversationId)async {
   return messagesRemoteDataSource.fetchMessages(conversationId);
  }

  @override
  Future<void> sendMessage(MessageEntity message) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }

  @override
  Future<DailyQuestionEntity> fetchDailyQuestion(String conversationId) async {
   return await messagesRemoteDataSource.fetchDailyQuestion(conversationId);
  }


}