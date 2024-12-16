import 'package:wori_app/core/features/data/datasources/contacts/contact_remote_data_source.dart';
import 'package:wori_app/core/features/domain/entities/contacts/contact_entity.dart';
import 'package:wori_app/core/features/domain/repositories/contacts/contacts_repository.dart';

class ContactRepositoryImpl implements ContactsRepository {
  final ContactRemoteDataSource contactRemoteDataSource;

  ContactRepositoryImpl({required this.contactRemoteDataSource});
  @override
  Future<void> addContact({required String email})async {
    return await contactRemoteDataSource.addContact(email: email);

  }

  @override
  Future<List<ContactEntity>> fetchContacts()async {
    return await contactRemoteDataSource.fetchContacts();
  }


}