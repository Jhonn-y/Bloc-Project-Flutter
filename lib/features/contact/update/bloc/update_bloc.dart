import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_project/models/contactModel.dart';
import 'package:bloc_project/repo/contactRepo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_event.dart';
part 'update_state.dart';
part 'update_bloc.freezed.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final ContactRepo _repo;
  UpdateBloc({required ContactRepo repository})
      : _repo = repository,
        super(const _UpdateStateInitial()) {
    on<_UpdateEventSave>(_save);
  }

  Future<void> _save(event, Emitter<UpdateState> emit) async {
    emit(UpdateState.loading());
    try {
      final contactModel = ContactModel(
        id: event.id,
        name: event.name,
        email: event.email,
      );

      await _repo.update(contactModel);
      emit(UpdateState.success());
    } catch (e) {
      emit(UpdateState.error(message: 'Erro ao atualizar contato'));
    }
  }
}
