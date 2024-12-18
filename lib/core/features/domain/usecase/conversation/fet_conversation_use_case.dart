import 'package:wori_app/core/features/domain/entities/conversation/conversation_entity.dart';
import 'package:wori_app/core/features/domain/repositories/conversation/conversations_repository.dart';

class FetchConversationUseCase {
  final ConversationsRepository repository;

  FetchConversationUseCase({required this.repository});

  Future<List<ConversationEntity>>call()async {
    return await repository.fetchConversations();
  }
}