import 'package:wori_app/core/features/domain/entities/contacts/contact_entity.dart';
import 'package:wori_app/core/features/domain/repositories/contacts/contacts_repository.dart';

class FetchContactUseCase {
  final ContactsRepository contactsRepository;

  FetchContactUseCase({required this.contactsRepository});

  Future<List<ContactEntity>>call()async {
    return await contactsRepository.fetchContacts();
  }
}