class User {
  final String id;
  final String userName;
  final String? dateOfBirth;
  final String? address;

  const User({
    required this.id,
    required this.userName,
    this.dateOfBirth,
    this.address,
  });
}
