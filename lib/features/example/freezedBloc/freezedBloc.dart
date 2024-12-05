import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezedState.dart';
part 'freezedEvent.dart';
part 'freezedBloc.freezed.dart';

class FreezedBloc extends Bloc<FreezedEvent, FreezedState> {
  FreezedBloc() : super(FreezedState.initial()) {
    on<FreezedEventFindNames>(_findNames);
    on<FreezedEventRemoveName>(_removeName);
    on<FreezedEventAddName>(_addName);
  }

  FutureOr<void> _removeName(
    FreezedEventRemoveName event,
    Emitter<FreezedState> emit,
  ) {
    final names =
        state.maybeWhen(data: (names) => names, orElse: () => const <String>[]);

    final newNames = [...names];

    newNames.retainWhere((element) => element != event.name);
    emit(FreezedState.data(names: newNames));
  }

  FutureOr<void> _addName(
    FreezedEventAddName event,
    Emitter<FreezedState> emit,
  ) {
    final names =
        state.maybeWhen(data: (names) => names, orElse: () => const <String>[]);

    emit(FreezedState.showBanner(names: names, message: 'Nome sendo inserido!'));

    final newNames = [...names];
    newNames.add(event.name);

    emit(FreezedState.data(names: newNames));
  }

  FutureOr<void> _findNames(
      FreezedEventFindNames event, Emitter<FreezedState> emit) async {
    emit(FreezedState.loading());
    final names = ['Alice', 'Bob', 'Charlie', 'David', 'Eve'];
    emit(FreezedState.data(names: names));
  }
}
