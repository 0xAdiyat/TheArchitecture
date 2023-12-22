class UserModel {
  String id;
  String username;
  String email;

  UserModel({required this.id, required this.username, required this.email});

  @override
  String toString() {
    return 'UserModel{id: $id, username: $username, email: $email}';
  }
}
