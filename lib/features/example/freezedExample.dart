import 'package:bloc_project/features/example/freezedBloc/freezedBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FreezedExample extends StatelessWidget {
  const FreezedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Freezed Example'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          context.read<FreezedBloc>().add(  FreezedEvent.addName('Nome Freezed'));
        },),
      body: BlocListener<FreezedBloc,FreezedState>(listener: (context, state) {
        state.whenOrNull(
          showBanner: (_,message){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
          }
        );
      },
      child:Column(
        children: [
          BlocSelector<FreezedBloc, FreezedState, bool>(
            selector: (state) {
              return state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              );
            },
            builder: (context, state) {
              if (state) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          BlocSelector<FreezedBloc,FreezedState, List<String>>(selector: (state){
            return state.maybeWhen(
              data: (names) => names,
              showBanner: (names,_) => names,
              orElse: () => [],

            );
          }, builder: (_,names){
            return ListView.builder(
              shrinkWrap: true,
              itemCount: names.length,
              itemBuilder: (context, index){
                return ListTile(
                  onTap: (){},
                  title: Text(names[index]),
                );
              },
            );
          })
          
        ],
      ),
    ),);
  }
}
