import 'package:wori_app/core/features/data/datasources/conversation/conversations_remote_data_source.dart';
import 'package:wori_app/core/features/domain/entities/conversation/conversation_entity.dart';

import '../../../domain/repositories/conversation/conversations_repository.dart';

class ConversationsRepositoryImpl implements ConversationsRepository {
  final ConversationsRemoteDataSource remoteDataSource;

  ConversationsRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<ConversationEntity>> fetchConversations()async {
 return await remoteDataSource.fetchConversations();
  }

  @override
  Future<String> checkOrCreateConversation({required String contactId}) async{
    return await remoteDataSource.checkOrCreateConversation(contactId: contactId);
  }
}

