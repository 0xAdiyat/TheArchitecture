import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_architecture/core/data/model/user_model.dart';
import 'package:the_architecture/core/data/repository/impl/user_repository_Impl.dart';
import 'package:the_architecture/core/presentation/view/user_list_view.dart';

class UserDetailsView extends ConsumerWidget {
  const UserDetailsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${user.username}'),
            Text('Email: ${user.email}'),
            const SizedBox(height: 16.0),
            OutlinedButton(
                onPressed: () {
                  final updatedUser = UserModel(
                      id: user.id, username: "Adiyat", email: "sus@gmail.com");
                  ref
                      .read(userRepositoryProvider)
                      .updateUser(user.id, updatedUser);
                  Navigator.pop(context);
                },
                child: const Text("Update")),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                ref.read(userRepositoryProvider).deleteUser(user.id);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
