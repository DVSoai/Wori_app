import 'package:wori_app/core/features/domain/entities/contacts/contact_entity.dart';

abstract class ContactsRepository {
  Future<List<ContactEntity>>fetchContacts();
  Future<void>addContact({required String email});
}