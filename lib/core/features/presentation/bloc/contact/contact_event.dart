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
  final String contactName;

  CheckOrCreateConversation({required this.contactId,required this.contactName});
}