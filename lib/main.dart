import 'package:bloc_project/features/contact/list/bloc/contactBloc.dart';
import 'package:bloc_project/features/contact/list/contactListPage.dart';
import 'package:bloc_project/features/contact/register/bloc/registerBloc.dart';
import 'package:bloc_project/features/contact/register/registerPage.dart';
import 'package:bloc_project/features/contact/update/bloc/update_bloc.dart';
import 'package:bloc_project/features/contact/update/updatePage.dart';
import 'package:bloc_project/features/example/bloc/exampleBloc.dart';
import 'package:bloc_project/features/example/blocExample.dart';
import 'package:bloc_project/features/example/freezedBloc/freezedBloc.dart';
import 'package:bloc_project/features/example/freezedExample.dart';
import 'package:bloc_project/home/homePage.dart';
import 'package:bloc_project/models/contactModel.dart';
import 'package:bloc_project/repo/contactRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ContactRepo(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
        routes: {
          '/bloc/example/': (_) => BlocProvider(
                create: (_) => ExampleBloc()..add(FindNameEvent()),
                child: const BlocExample(),
              ),
          '/bloc/example/freezed': (_) => BlocProvider(
                create: (context) =>
                    FreezedBloc()..add(FreezedEvent.findNames()),
                child: const FreezedExample(),
              ),
          'contact/list': (_) => BlocProvider(
                create: (context) =>
                    ContactBloc(repository: context.read<ContactRepo>())
                      ..add(ContactEvent.findAll()),
                child: const ContactListPage(),
              ),
          'contact/register': (context) => BlocProvider(
                create: (context) => RegisterBloc(repository: context.read()),
                child: const RegisterPage(),
              ),
          'contact/update': (context) {
            
            final contact = ModalRoute.of(context)?.settings.arguments as ContactModel;
            
            return BlocProvider(
                create: (context) => UpdateBloc(
                  repository: context.read(),
                ),
                child: UpdatePage(
                  contact: contact,
                ),
              );
          }
        },
      ),
    );
  }
}
