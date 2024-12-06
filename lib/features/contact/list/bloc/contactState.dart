
part of 'contactBloc.dart';


@freezed
class ContactState with _$ContactState{
  factory ContactState.initial() = _ContactStateInitial;
  factory ContactState.data({ required List<ContactModel> contacts}) = _ContactStateData;
  factory ContactState.error({required String errorMessage}) = _ContactStateError;
  factory ContactState.loading() = _ContactStateLoading;
  
}