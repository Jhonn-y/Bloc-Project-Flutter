
part of 'updateCubit.dart';

@freezed
class UpdateCubitState with _$UpdateCubitState{
  factory UpdateCubitState.initial() = _UpdateCubitInitial;
  factory UpdateCubitState.success() = _UpdateCubitSuccess;
  factory UpdateCubitState.error({required String error}) = _UpdateCubitError;
  factory UpdateCubitState.loading() = _UpdateCubitLoading;
  
}