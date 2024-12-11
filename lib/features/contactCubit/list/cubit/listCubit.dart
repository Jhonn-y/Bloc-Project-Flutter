import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_project/models/contactModel.dart';
import 'package:bloc_project/repo/contactRepo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'listCubitState.dart';
part 'listCubit.freezed.dart';

class ListCubit extends Cubit<ListCubitState> {
  final ContactRepo _repo;
  ListCubit({required ContactRepo repository})
      : _repo = repository,
        super(ListCubitState.initial());

    Future<void> findAll() async {
      emit(ListCubitState.loading());

      try {
        final contact = await _repo.findAll();

        emit(ListCubitState.data(model: contact));
      } catch (e) {
        emit(ListCubitState.error(error: 'Erro ao buscar contatos!'));
      }
  }

  Future<void> delete(ContactModel model) async {
    emit(ListCubitState.loading());

      try {
      await _repo.delete(model);

        findAll();
      } catch (e) {
        emit(ListCubitState.error(error: 'Erro ao excluir contato!'));
      }
  }




}
