import 'package:wori_app/core/features/domain/entities/message/message_entity.dart';
import 'package:wori_app/core/features/domain/repositories/message/messages_repository.dart';

class FetchMessagesUseCase {
  final MessagesRepository messagesRepository;
  FetchMessagesUseCase({required this.messagesRepository});

  Future<List<MessageEntity>> call(String conversationId) async {
    return await messagesRepository.fetchMessages(conversationId);
  }
}