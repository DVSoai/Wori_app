import 'package:wori_app/core/features/domain/entities/contacts/contact_entity.dart';
import 'package:wori_app/core/features/domain/repositories/contacts/contacts_repository.dart';

class FetchRecentContactUseCase {
  final ContactsRepository contactsRepository;

  FetchRecentContactUseCase({required this.contactsRepository});

  Future<List<ContactEntity>>call()async {
    return await contactsRepository.fetchRecentContacts();
  }
}