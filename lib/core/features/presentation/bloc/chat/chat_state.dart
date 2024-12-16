import 'package:wori_app/core/features/domain/entities/message/message_entity.dart';

abstract class ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<MessageEntity> messages;

  ChatLoadedState(this.messages);
}

class ChatErrorState extends ChatState {
  final String message;

  ChatErrorState(this.message);
}