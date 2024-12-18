import 'package:wori_app/core/features/domain/entities/contacts/contact_entity.dart';
import 'package:wori_app/core/features/domain/entities/conversation/conversation_entity.dart';


abstract class ContactState{}

class ContactInitial extends ContactState{}
class ContactLoading extends ContactState{}
class ContactLoaded extends ContactState{
  final List<ContactEntity> contacts;

  ContactLoaded(this.contacts);
}
class ContactError extends ContactState{
  final String message;

  ContactError(this.message);
}
class ContactAdded extends ContactState{}
class ConversationReady extends ContactState{
  final String conversationId;
  final ContactEntity contact;

  ConversationReady({required this.conversationId, required this.contact});
}

class RecentContactLoaded extends ContactState{
  final List<ContactEntity> recentContacts;
  RecentContactLoaded( this.recentContacts);
}

