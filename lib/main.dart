import 'package:bloc_project/features/example/bloc/exampleBloc.dart';
import 'package:bloc_project/features/example/blocExample.dart';
import 'package:bloc_project/features/example/freezedBloc/freezedBloc.dart';
import 'package:bloc_project/features/example/freezedExample.dart';
import 'package:bloc_project/home/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          create: (context) => FreezedBloc()..add(FreezedEvent.findNames()),
          child: const FreezedExample(),)
      },
    );
  }
}
