import 'package:flutter/material.dart';
import 'package:mvvm_project/di.dart';
import 'package:mvvm_project/viewmodels/login/login_viewmodel.dart';
import 'package:mvvm_project/viewmodels/usermanagement/users_viewmodels.dart';
import 'package:mvvm_project/views/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
          create: (_)=>buildLoginVM(),
        ),
        ChangeNotifierProvider<UsersViewModels>(
          create: (_)=>buildUserViewModel(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}

