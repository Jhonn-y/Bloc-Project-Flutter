import 'dart:async';

import 'package:bloc_project/models/contactModel.dart';
import 'package:bloc_project/repo/contactRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'updateCubitState.dart';
part 'updateCubit.freezed.dart';

class UpdateCubit extends Cubit<UpdateCubitState> {
  ContactRepo _repo;
  UpdateCubit({required ContactRepo repository})
      : _repo = repository,
        super(UpdateCubitState.initial());

  FutureOr<void> update({required id, required  String name,required  String email}) async {
    emit(UpdateCubitState.loading());

    try {
      final model = ContactModel(id: id ,name: name,email: email);
      await _repo.update(model);
      emit(UpdateCubitState.success());
    } catch (e) {
      emit(UpdateCubitState.error(error: 'Erro ao atualizar contato!'));
    }
  }
}
