import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:the_architecture/core/data/repository/impl/user_repository_Impl.dart';
import 'package:the_architecture/core/presentation/view/user_list_view.dart';

import '../../data/model/user_model.dart';
import '../../utils/validators.dart';
import '../widgets/custom_text_form_field.dart';

class UserDetailsView extends HookConsumerWidget {
  const UserDetailsView({super.key});

  void updateUser(String id, String name, String email, WidgetRef ref,
      BuildContext context) {
    final newUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: name,
        email: email);
    ref.read(userRepositoryProvider.notifier).updateUser(id, newUser);

    Navigator.pop(context);
  }

  void deleteUser(WidgetRef ref, String id, BuildContext context) {
    ref.read(userRepositoryProvider.notifier).deleteUser(id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.read(userProvider).id;
    final user = ref.watch(userRepositoryProvider.notifier).getUserById(id);

    final usernameEditingController = useTextEditingController();
    final emailEditingController = useTextEditingController();
    usernameEditingController.text = user.username;
    emailEditingController.text = user.email;

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                controller: usernameEditingController,
                labelText: "username",
                prefixIcon: CupertinoIcons.person,
                keyboardType: TextInputType.name,
                validator: validateName,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFormField(
                controller: emailEditingController,
                labelText: "e-mail",
                prefixIcon: CupertinoIcons.mail,
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.maxFinite,
                height: 60,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () => formKey.currentState!.validate()
                        ? updateUser(id, usernameEditingController.text,
                            emailEditingController.text, ref, context)
                        : null,
                    child: const Text("Update")),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: double.maxFinite,
                height: 60,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () => formKey.currentState!.validate()
                        ? deleteUser(ref, id, context)
                        : null,
                    child: const Text("Delete")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
