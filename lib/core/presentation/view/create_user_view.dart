import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:the_architecture/core/data/model/user_model.dart';
import 'package:the_architecture/core/data/repository/impl/user_repository_Impl.dart';

import '../../utils/validators.dart';
import '../widgets/custom_text_form_field.dart';

class CreateUserView extends HookConsumerWidget {
  const CreateUserView({Key? key}) : super(key: key);

  void createUser(
      String name, String email, WidgetRef ref, BuildContext context) {
    final newUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: name,
        email: email);
    ref.read(userRepositoryProvider.notifier).createUser(newUser);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, ref) {
    final usernameEditingController = useTextEditingController();
    final emailEditingController = useTextEditingController();

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create User"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const Icon(CupertinoIcons.alt),
                const SizedBox(
                  height: 20,
                ),
                const Text("Hey..", style: TextStyle(fontSize: 20)),
                const SizedBox(
                  height: 20,
                ),
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
                const SizedBox(
                  height: 16,
                ),
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
                          ? createUser(usernameEditingController.text,
                              emailEditingController.text, ref, context)
                          : null,
                      child: const Text("Create")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
