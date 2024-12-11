import 'dart:async';

import 'package:bloc_project/models/contactModel.dart';
import 'package:bloc_project/repo/contactRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contactEvent.dart';
part 'contactState.dart';

part 'contactBloc.freezed.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepo _repo;
  ContactBloc({required ContactRepo repository})
      : _repo = repository,
        super(ContactState.initial()) {
    on<_ContactEventFindAll>(_findAll);
    on<_ContactEventDelete>(_delete);
  }

  FutureOr<void> _findAll(
      _ContactEventFindAll event, Emitter<ContactState> emit) async {
    try {
      emit(ContactState.loading());
      final contacts = await _repo.findAll();
      emit(ContactState.data(contacts: contacts));
    } catch (e) {
      emit(ContactState.error(errorMessage: 'Erro ao buscar contatos!'));
    }
  }

  Future<void> _delete(
      _ContactEventDelete event, Emitter<ContactState> emit) async {
    try {
      await _repo.delete(event.model);
      add(ContactEvent.findAll());
    } catch (e) {
      emit(ContactState.error(errorMessage: 'Erro ao excluir contato!'));
    }
  }
}
