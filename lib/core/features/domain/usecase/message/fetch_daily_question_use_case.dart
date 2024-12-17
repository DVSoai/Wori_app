import 'package:wori_app/core/features/domain/repositories/message/messages_repository.dart';

import '../../entities/message/daily_question_entity.dart';

class FetchDailyQuestionUseCase {
  final MessagesRepository messagesRepository;

  FetchDailyQuestionUseCase({required this.messagesRepository});

  Future<DailyQuestionEntity> call(String conversationId) async {
    return await messagesRepository.fetchDailyQuestion(conversationId);
  }
}