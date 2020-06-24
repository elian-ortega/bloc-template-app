class User {
  final String fullName;
  final String email;
  final String id;

  const User({
    this.fullName,
    this.email,
    this.id,
  });

  User.fromMap(Map<String, dynamic> data)
      : fullName = data['fullName'],
        email = data['email'],
        id = data['id'];

  Map<String, dynamic> toMap() => {
        'fullName': fullName,
        'email': email,
        'id': id,
      };
}
