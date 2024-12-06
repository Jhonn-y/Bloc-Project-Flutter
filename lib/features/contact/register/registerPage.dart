import 'package:bloc_project/features/contact/register/bloc/registerBloc.dart';
import 'package:bloc_project/features/loader.dart';
import 'package:bloc_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          state.whenOrNull(
              success: () => Navigator.of(context).pop(),
              error: (message) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          message,
                          style: const TextStyle(color: Colors.white),
                        )),
                  ));
        },
        listenWhen: (previous, current) {
          return current.maybeWhen(
            success: () => true,
            error: (_) => true,
            orElse: () => false);
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      label: Text('Nome'),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Nome é obrigatório.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      label: Text('Email'),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Email é obrigatório.';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final validate =
                            _formKey.currentState?.validate() ?? false;
                        if (validate) {
                          context.read<RegisterBloc>().add(
                                RegisterEvent.save(
                                    name: _nameController.text,
                                    email: _emailController.text),
                              );
                        }
                      },
                      child: const Text('Salvar')),
                  Loader<RegisterBloc, RegisterState>(
                    selector: (state) {
                      return state.maybeWhen(
                          loading: () => true, orElse: () => false);
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
