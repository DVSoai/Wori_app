import 'package:wori_app/core/features/domain/entities/conversation/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel({
    required id,
    required participantName,
    required participantImage,
    required lastMessage,
    required lastMessageTime,

}):super(
    id: id,
    participantName: participantName,
    participantImage: participantImage,
    lastMessage: lastMessage,
    lastMessageTime: lastMessageTime,

  );

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['conversation_id'] ?? '',
      participantName: json['participant_name']?? '',
      participantImage: json['participant_image']?? 'https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/anh-avatar-cute-58.jpg',
      lastMessage: json['last_message']?? '',
      lastMessageTime: json['last_message_time'] != null && json['last_message_time'] is String
          ? DateTime.tryParse(json['last_message_time']) ?? DateTime.now()
          : DateTime.now(),

    );
  }
}