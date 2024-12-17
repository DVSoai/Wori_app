import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wori_app/core/features/presentation/bloc/contact/contact_event.dart';
import 'package:wori_app/core/features/presentation/bloc/contact/contact_state.dart';

import '../../../domain/usecase/contacts/add_contact_use_case.dart';
import '../../../domain/usecase/contacts/fetch_contact_use_case.dart';
import '../../../domain/usecase/conversation/check_or_create_conversation_use_case.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final FetchContactUseCase fetchContactUseCase;
  final AddContactUseCase addContactUseCase;
  final CheckOrCreateConversationUseCase checkOrCreateConversationUseCase;

  ContactBloc(
      {required this.fetchContactUseCase,
      required this.addContactUseCase,
      required this.checkOrCreateConversationUseCase})
      : super(ContactInitial()) {
    on<FetchContacts>(_onFetchContacts);
    on<AddContacts>(_onAddContact);
    on<CheckOrCreateConversation>(_onCheckOrCreateConversation);
  }

  Future<void> _onAddContact(
      AddContacts event, Emitter<ContactState> emit) async {
    emit(ContactLoading());
    try {
      await addContactUseCase(email: event.email);
      emit(ContactAdded());
      add(FetchContacts());
    } catch (e) {
      debugPrint(e.toString());
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onFetchContacts(
      FetchContacts event, Emitter<ContactState> emit) async {
    emit(ContactLoading());
    try {
      final contacts = await fetchContactUseCase();
      emit(ContactLoaded(contacts));
    } catch (e) {
      debugPrint(e.toString());
      emit(ContactError(e.toString()));
    }
  }
  Future<void> _onCheckOrCreateConversation(CheckOrCreateConversation event, Emitter<ContactState> emit) async {
    emit(ContactLoading());
    try {
      final conversationId = await checkOrCreateConversationUseCase(contactId: event.contactId);
      emit(ConversationReady(conversationId : conversationId, contact : event.contact));
    } catch (e) {
      debugPrint(e.toString());
      emit(ContactError(e.toString()));
    }
  }
}
