// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_project/features/contactCubit/update/cubit/updateCubit.dart';
import 'package:bloc_project/features/loader.dart';
import 'package:bloc_project/models/contactModel.dart';

class UpdateCubitPage extends StatefulWidget {
  final ContactModel _contact;
  UpdateCubitPage({
    super.key,
    required  ContactModel contact,
  }):
  _contact = contact;


  @override
  State<UpdateCubitPage> createState() => _UpdateCubitPageState();
}

class _UpdateCubitPageState extends State<UpdateCubitPage> {

final _formKey = GlobalKey<FormState>();
late final TextEditingController _nameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget._contact.name);
    _emailController = TextEditingController(text: widget._contact.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Scaffold(
      appBar: AppBar(
        title: const Text('Contact Update'),
      ),
      body: BlocListener<UpdateCubit, UpdateCubitState>(
        listener: (context, state) {
          state.whenOrNull(
              success: () => Navigator.of(context).pop(),
              error: (message) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(message,
                      style: const TextStyle(color: Colors.white),)),
                  ));
        },
        listenWhen: (previous, current) {
          return current.maybeWhen(
              success: () => true, error: (_) => true, orElse: () => false);
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
                          context.read<UpdateCubit>().update(
                          id: widget._contact.id,  
                          name: _nameController.text,
                          email:_emailController.text);
                        }
                      },
                      child: const Text('Salvar')),
                  Loader<UpdateCubit, UpdateCubitState>(
                    selector: (state) {
                      return state.maybeWhen(
                          loading: () => true, orElse: () => false);
                    },
                  ),
                ],
              )),
        ),
      ),
    ),
    );
  }
}