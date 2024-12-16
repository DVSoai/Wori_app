import 'package:wori_app/core/features/domain/entities/conversation/conversation_entity.dart';

abstract class ConversationsRepository {
  Future<List<ConversationEntity>> fetchConversations();
  Future<String> checkOrCreateConversation({required String contactId});
}