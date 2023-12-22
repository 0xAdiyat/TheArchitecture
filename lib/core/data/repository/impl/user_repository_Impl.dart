import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/user_model.dart';
import '../user_repository.dart';

final userRepositoryProvider = Provider.autoDispose<UserRepository>((ref) {
  return UserRepositoryImpl();
});

class UserRepositoryImpl implements UserRepository {
  final List<UserModel> _users = [];

  @override
  void createUser(UserModel user) => _users.add(user);

  @override
  void deleteUser(String id) =>
      _users.removeWhere((element) => element.id == id);

  @override
  List<UserModel> getAllUsers() => List.from(_users);
  @override
  UserModel getUserById(String id) =>
      _users.firstWhere((element) => element.id == id,
          orElse: () => UserModel(id: '', username: '', email: ''));

  @override
  void updateUser(String id, UserModel updatedUser) {
    final existingUser = getUserById(id);
    if (existingUser.id.isNotEmpty) {
      _users[_users.indexOf(existingUser)] = updatedUser;
    }
  }
}
