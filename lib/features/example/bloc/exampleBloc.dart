import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'exampleBlocEvent.dart';
part 'exampleBlocState.dart';

class ExampleBloc extends Bloc<ExampleBlocEvent, ExampleBlocState> {
  ExampleBloc() : super(InitialState()) {
    on<FindNameEvent>(_findNames);
    on<RemoveNameEvent>(_removeName);
    on<AddNameEvent>(_addName);
  }

FutureOr<void> _removeName(
  RemoveNameEvent event,
  Emitter<ExampleBlocState> emit,
) {
  final stateExample = state;

  if (stateExample is StateData) {

    final names = [...stateExample.names];
    names.retainWhere((element) => element != event.name);
    emit(StateData(names: names));
    
  }
}

FutureOr<void> _addName(
  AddNameEvent event, Emitter<ExampleBlocState> emit,
){

  final stateExample = state;
  if (stateExample is StateData) {
    final names = [...stateExample.names, event.name];
    emit(StateData(names: names));
  }

}



FutureOr<void> _findNames(
    FindNameEvent event, Emitter<ExampleBlocState> emit) async {
  final names = ['Alice', 'Bob', 'Charlie', 'David', 'Eve'];
  emit(StateData(names: names));
}
}
