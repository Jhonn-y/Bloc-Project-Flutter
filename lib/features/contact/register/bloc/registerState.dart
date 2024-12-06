
part of 'registerBloc.dart';

@freezed
class RegisterState with _$RegisterState{
  factory RegisterState.initial() = _RegisterStateInitial;
  factory RegisterState.loading() = _RegisterStateLoading;
  factory RegisterState.error({required String message}) = _RegisterStateError;
  factory RegisterState.success() = _RegisterStateSuccess;
  
}