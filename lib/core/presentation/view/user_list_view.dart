import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_architecture/core/data/repository/impl/user_repository_Impl.dart';
import 'package:the_architecture/core/presentation/view/create_user_view.dart';
import 'package:the_architecture/core/presentation/view/user_details_view.dart';

import '../../data/model/user_model.dart';

final userProvider = Provider<UserModel>((ref) {
  return UserModel(id: '', username: '', email: '');
});

class UserListView extends ConsumerWidget {
  const UserListView({super.key});

  void navigateToCreateUserView(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => const CreateUserView()));
  void navigateToUserDetailsView(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserDetailsView()));
  @override
  Widget build(BuildContext context, ref) {
    final users = ref.watch(userRepositoryProvider);
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD"),
      ),
      body: users.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline_rounded),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "No user was created to display",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => navigateToCreateUserView(context),
                    child: const Text("Create user"),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.username),
                  subtitle: Text(user.email),
                  onTap: () {
                    ref.read(userProvider).id = user.id;
                    navigateToUserDetailsView(context);
                  },
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToCreateUserView(context),
        child: Icon(CupertinoIcons.pen),
      ),
    );
  }
}
