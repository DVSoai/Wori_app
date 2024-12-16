abstract class ChatEvent {}

class LoadMessagesEvent extends ChatEvent {
  final String conversationId;

  LoadMessagesEvent(this.conversationId);
}

class SendMessageEvent extends ChatEvent {
  final String conversationId;
  final String content;

  SendMessageEvent(this.conversationId, this.content);
}

class ReceiveMessageEvent extends ChatEvent {
final Map<String, dynamic> message;

  ReceiveMessageEvent(this.message);
}