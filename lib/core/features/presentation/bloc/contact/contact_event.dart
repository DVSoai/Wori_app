import 'package:wori_app/core/features/domain/entities/contacts/contact_entity.dart';
import 'package:wori_app/core/features/domain/entities/conversation/conversation_entity.dart';

abstract class ContactEvent {
}

class AddContacts extends ContactEvent {
  final String email;

  AddContacts({required this.email});
}

class FetchContacts extends ContactEvent {

}
class CheckOrCreateConversation extends ContactEvent {
  final String contactId;
  final ContactEntity contact;

  CheckOrCreateConversation({required this.contactId,required this.contact});
}

class LoadRecentContact extends ContactEvent{}