import '../model/user_model.dart';

abstract class UserRepository {
  List<UserModel> getAllUsers();
  UserModel getUserById(String id);
  void createUser(UserModel user);
  void updateUser(String id, UserModel updatedUser);
  void deleteUser(String id);
}
