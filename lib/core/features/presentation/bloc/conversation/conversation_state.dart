import 'package:wori_app/core/features/domain/entities/conversation/conversation_entity.dart';

abstract class ConversationState{}

class ConversationsInitial extends ConversationState{}
class ConversationsLoading extends ConversationState{}
class ConversationsLoaded extends ConversationState{
  final List<ConversationEntity> conversations;
  ConversationsLoaded( this.conversations);
}

class ConversationsError extends ConversationState{
  final String message;
  ConversationsError(this.message);
}