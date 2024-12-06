part of 'update_bloc.dart';

@freezed
class UpdateEvent with _$UpdateEvent {
  const factory UpdateEvent.save({
    required String id,
    required String name,
    required String email,
  }) = _UpdateEventSave;
}