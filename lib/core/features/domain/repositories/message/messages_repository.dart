import 'package:wori_app/core/features/domain/entities/message/message_entity.dart';

abstract class MessagesRepository {
  Future<List<MessageEntity>> fetchMessages(String conversationId);
  Future<void> sendMessage(MessageEntity message);
}