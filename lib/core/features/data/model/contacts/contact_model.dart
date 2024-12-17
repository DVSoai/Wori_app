import 'package:wori_app/core/features/domain/entities/contacts/contact_entity.dart';

class ContactModel extends ContactEntity {
  ContactModel({
    required String id,
    required String username,
    required String email,
    required String profileImage,

  }) : super(
          id: id,
          username: username,
          email: email,
    profileImage: profileImage,
        );

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['contact_id'],
      username: json['username'],
      email: json['email'],
      profileImage: json['profile_image'] ?? 'https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/anh-avatar-cute-58.jpg',

    );
  }


}