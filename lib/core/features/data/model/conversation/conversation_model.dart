import 'package:wori_app/core/features/domain/entities/conversation/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel({
    required id,
    required participantName,
    required lastMessage,
    required lastMessageTime,
}):super(
    id: id,
    participantName: participantName,
    lastMessage: lastMessage,
    lastMessageTime: lastMessageTime,
  );

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['conversation_id'] ?? '',
      participantName: json['participant_name']?? '',
      lastMessage: json['last_message']?? '',
      lastMessageTime: DateTime.parse(json['last_message_time']),
    );
  }
}