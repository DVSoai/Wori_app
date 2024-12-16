
import 'package:wori_app/core/features/domain/repositories/contacts/contacts_repository.dart';

class AddContactUseCase {
  final ContactsRepository contactsRepository;

  AddContactUseCase({required this.contactsRepository});

  Future<void>call({required String email})async {
    return await contactsRepository.addContact(email: email);
  }
}