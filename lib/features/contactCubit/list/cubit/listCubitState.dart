
part of 'listCubit.dart';


@freezed
class ListCubitState with _$ListCubitState{
  factory ListCubitState.initial() = _ListCubitStateInitial;
  factory ListCubitState.loading() = _ListCubitStateLoading;
  factory ListCubitState.data({ required List<ContactModel> model}) = _ListCubitStateData;
  factory ListCubitState.error({required String error}) = _ListCubitStateError;

}