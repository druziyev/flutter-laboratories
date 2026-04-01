import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/blocs/auth/auth_bloc.dart';
import 'package:form_app/blocs/auth/auth_event.dart';
import 'package:form_app/blocs/auth/auth_state.dart';
import 'package:form_app/pages/main_page.dart';

class RegisterPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // navigate on success
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainPage()),
          );
        } else if (state is AuthFailure) {
          // show error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  // show spinner while loading
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            RegisterEvent(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                    },
                    child: const Text('Register'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
