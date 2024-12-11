import 'dart:async';

import 'package:bloc_project/models/contactModel.dart';
import 'package:bloc_project/repo/contactRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'registerCubitState.dart';
part 'registerCubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterCubitState> {
  ContactRepo _repo;
  RegisterCubit({required ContactRepo repository})
      : _repo = repository,
        super(RegisterCubitState.initial());

  FutureOr<void> save({required String name, required String email}) async {
    emit(RegisterCubitState.loading());

    try {
      final model = ContactModel(name: name, email: email);
      await _repo.create(model);
      emit(RegisterCubitState.success());
    } catch (e) {
      emit(RegisterCubitState.error(message: 'Erro ao cadastrar contato'));
    }
  }
}
