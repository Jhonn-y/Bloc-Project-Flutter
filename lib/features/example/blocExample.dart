import 'package:bloc_project/features/example/bloc/exampleBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocExample extends StatefulWidget {
  const BlocExample({super.key});

  @override
  State<BlocExample> createState() => _BlocExampleState();
}

class _BlocExampleState extends State<BlocExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: BlocListener<ExampleBloc, ExampleBlocState>(
          listener: (context, state) {
            if (state is StateData) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(' a quantidade de nomes é ${state.names.length}'),
                ),
              );
            }
          },
          child: Column(children: [
            BlocConsumer<ExampleBloc, ExampleBlocState>(
                builder: (_, state) {
                  if (state is StateData) {
                    return Text(
                        ' a quantidade certa mesmo de nomes é ${state.names.length}');
                  }
                  return const SizedBox.shrink();
                },
                listener: (context, state) {}),
            BlocSelector<ExampleBloc, ExampleBlocState, bool>(selector: (state) {
              if (state is InitialState) {
                return true;
              }
              return false;
            }, builder: (context, showloader) {
              if (showloader) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const SizedBox.shrink();
            }),
            BlocBuilder<ExampleBloc, ExampleBlocState>(
              builder: (context, state) {
                if (state is StateData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.names.length,
                    itemBuilder: (context, index) {
                      final name = state.names[index];
                      return ListTile(
                        onTap: () {
                          context
                              .read<ExampleBloc>()
                              .add(RemoveNameEvent(name: name));
                        },
                        title: Text(name),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                      labelText: 'Adicionar nome',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um nome';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context
                            .read<ExampleBloc>()
                            .add(AddNameEvent(name: _name.text));
                      }
                    },
                    child: const Text('Adicionar nome'),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
