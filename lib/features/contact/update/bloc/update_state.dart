part of 'update_bloc.dart';

@freezed
class UpdateState with _$UpdateState {
  const factory UpdateState.initial() = _UpdateStateInitial;
  factory UpdateState.success() = _UpdateStateSuccess;
  factory UpdateState.error({required String message}) = _UpdateStateError;
  factory UpdateState.loading() = _UpdateStateLoading;
}
