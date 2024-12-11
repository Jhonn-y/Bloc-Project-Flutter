
part of 'registerCubit.dart';

@freezed
class RegisterCubitState with _$RegisterCubitState{
  factory RegisterCubitState.initial() = _RegisterCubitInitial;
  factory RegisterCubitState.error({ required String message }) = _RegisterCubitError;
  factory RegisterCubitState.success() = _RegisterCubitSuccess;
  factory RegisterCubitState.loading() = _RegisterCubitLoading;
  
}