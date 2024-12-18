
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wori_app/core/features/domain/usecase/contacts/fetch_recent_contact_use_case.dart';
import 'package:wori_app/core/features/presentation/bloc/conversation/conversation_event.dart';
import 'package:wori_app/core/features/presentation/bloc/conversation/conversation_state.dart';

import '../../../../socket_service.dart';
import '../../../domain/usecase/conversation/fet_conversation_use_case.dart';

class ConversationBloc extends Bloc<ConversationEvent,ConversationState>{
  final FetchConversationUseCase fetchConversationUseCase;
  final FetchRecentContactUseCase fetchRecentContactUseCase;

  final SocketService _socketService = SocketService();

  ConversationBloc({required this.fetchConversationUseCase,required this.fetchRecentContactUseCase}) : super(ConversationsInitial()){
    on<FetchConversationsEvent>(_onFetchConversations);
    // on<LoadRecentContactEvent>(_onFetchRecentContacts);
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
  // Future<void>_onFetchRecentContacts(LoadRecentContactEvent event, Emitter<ConversationState> emit)async{
  //   emit(ConversationsLoading());
  //   try{
  //     debugPrint("Fetching recent contacts vao day");
  //     final recentContacts = await fetchRecentContactUseCase.call();
  //     emit(RecentContactLoaded(recentContacts));
  //   }catch(e){
  //     emit(ConversationsError(e.toString()));
  //   }
  // }
}