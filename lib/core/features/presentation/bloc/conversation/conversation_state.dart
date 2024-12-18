import 'package:wori_app/core/features/domain/entities/contacts/contact_entity.dart';
import 'package:wori_app/core/features/domain/entities/conversation/conversation_entity.dart';

abstract class ConversationState{}

class ConversationsInitial extends ConversationState{}
class ConversationsLoading extends ConversationState{}
class ConversationsLoaded extends ConversationState{
  final List<ConversationEntity> conversations;
  ConversationsLoaded( this.conversations);
}
class RecentContactLoaded extends ConversationState{
  final List<ContactEntity> recentContacts;
  RecentContactLoaded( this.recentContacts);
}

class ConversationsError extends ConversationState{
  final String message;
  ConversationsError(this.message);
}