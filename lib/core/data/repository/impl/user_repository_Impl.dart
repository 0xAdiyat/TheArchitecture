import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/user_model.dart';
import '../user_repository.dart';

final userRepositoryProvider =
    StateNotifierProvider<UserRepositoryImpl, List<UserModel>>((ref) {
  return UserRepositoryImpl([]);
});

class UserRepositoryImpl extends StateNotifier<List<UserModel>>
    implements UserRepository {
  UserRepositoryImpl(List<UserModel> users) : super(users);

  @override
  void createUser(UserModel user) => state = [...state, user];

  @override
  void deleteUser(String id) =>
      state = state.where((element) => element.id != id).toList();

  @override
  List<UserModel> getAllUsers() => state;
  @override
  UserModel getUserById(String id) =>
      state.firstWhere((element) => element.id == id,
          orElse: () => UserModel(id: '', username: '', email: ''));

  @override
  void updateUser(String id, UserModel updatedUser) {
    // final existingUser = getUserById(id);
    // if (existingUser.id.isNotEmpty) {
    //   state[state.indexOf(existingUser)] = updatedUser;
    // }
    state = state.map((user) => user.id == id ? updatedUser : user).toList();
  }
}
