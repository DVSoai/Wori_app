class ContactEntity {
  final String id;
  final String username;
  final String email;
  final String? profileImage;

  const ContactEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.profileImage,
});
}