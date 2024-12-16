import 'package:wori_app/core/features/domain/repositories/conversation/conversations_repository.dart';

class CheckOrCreateConversationUseCase {
  final ConversationsRepository conversationsRepository;
  CheckOrCreateConversationUseCase({required this.conversationsRepository});

  Future<String> call({required String contactId})async {
    return await conversationsRepository.checkOrCreateConversation(contactId: contactId);
  }
}