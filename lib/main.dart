import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_architecture/core/data/repository/impl/user_repository_Impl.dart';
import 'package:the_architecture/core/presentation/view/user_list_view.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
  final userRepository = UserRepositoryImpl();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const UserListView(),
    );
  }
}
