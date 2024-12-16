
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wori_app/core/features/presentation/bloc/conversation/conversation_event.dart';
import 'package:wori_app/core/features/presentation/bloc/conversation/conversation_state.dart';

import '../../../../socket_service.dart';
import '../../../domain/usecase/conversation/fet_conversation_use_case.dart';

class ConversationBloc extends Bloc<ConversationEvent,ConversationState>{
  final FetchConversationUseCase fetchConversationUseCase;

  final SocketService _socketService = SocketService();

  ConversationBloc({required this.fetchConversationUseCase}) : super(ConversationsInitial()){
    on<FetchConversationsEvent>(_onFetchConversations);
    _initializeSocketListeners();
  }
  void _initializeSocketListeners(){
    try{
      _socketService.socket.on("conversationUpdated", _onConversationUpdated);
    }catch(e){
      debugPrint("Error initializing socket listeners: $e");
    }
  }
  Future<void>_onFetchConversations(FetchConversationsEvent event, Emitter<ConversationState> emit)async{
    emit(ConversationsLoading());
    try{
      final conversations = await fetchConversationUseCase.call();
      emit(ConversationsLoaded(conversations));
    }catch(e){
      emit(ConversationsError(e.toString()));
    }
  }
  void _onConversationUpdated(data){
    add(FetchConversationsEvent());
  }
}