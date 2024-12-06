import 'dart:async';

import 'package:bloc_project/models/contactModel.dart';
import 'package:bloc_project/repo/contactRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'registerEvent.dart';
part 'registerState.dart';
part "registerBloc.freezed.dart";

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  ContactRepo _repo;
  RegisterBloc({required ContactRepo repository})
      : _repo = repository,
        super(RegisterState.initial()) {
    on<__RegisterEventSave>(_save);
  }

  Future<void> _save(
      __RegisterEventSave event, Emitter<RegisterState> emit) async {
    emit(RegisterState.loading());
    try {
  final contactModel = ContactModel(name: event.name, email: event.email);
  
  await _repo.create(contactModel);
  emit(RegisterState.success());
}catch (e) {
  emit(RegisterState.error(message: 'Erro ao salvar contato'));
}
  }
}
