import 'package:wori_app/core/features/domain/entities/contacts/contact_entity.dart';

class ContactModel extends ContactEntity {
  ContactModel({
    required String id,
    required String username,
    required String email,

  }) : super(
          id: id,
          username: username,
          email: email,
        );

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['contact_id'],
      username: json['username'],
      email: json['email'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contact_id': id,
      'username': username,
      'email': email,
    };
  }
}