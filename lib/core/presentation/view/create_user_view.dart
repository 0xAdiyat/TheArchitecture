import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:the_architecture/core/data/model/user_model.dart';
import 'package:the_architecture/core/data/repository/impl/user_repository_Impl.dart';

class CreateUserView extends HookConsumerWidget {
  const CreateUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.read(userRepositoryProvider);

    final usernameEditingController = useTextEditingController();
    final emailEditingController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create User"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Form(
            // key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const Icon(Icons.flag),
                const SizedBox(
                  height: 20,
                ),
                const Text("Hey..", style: TextStyle(fontSize: 20)),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: usernameEditingController,
                  // validator: (val) => validateName(val!),
                  decoration: InputDecoration(
                    labelText: "username",
                    prefixIcon: const Icon(CupertinoIcons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailEditingController,
                  // validator: (val) => validateDepartment(val!),
                  decoration: InputDecoration(
                    labelText: "e-mail",
                    prefixIcon: const Icon(CupertinoIcons.device_desktop),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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
                      onPressed: () {
                        final newUser = UserModel(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            username: usernameEditingController.text,
                            email: emailEditingController.text);
                        user.createUser(newUser);
                        Navigator.pop(context);
                      },
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
