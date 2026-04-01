import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/blocs/auth/auth_bloc.dart';
import 'package:form_app/pages/register_page.dart';
import 'package:form_app/repositories/auth_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // provide auth bloc
      create: (_) => AuthBloc(AuthRepository()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RegisterPage(),
      ),
    );
  }
}
