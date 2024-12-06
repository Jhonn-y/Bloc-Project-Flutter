

part of 'registerBloc.dart';

@freezed
class RegisterEvent with _$RegisterEvent{
  factory RegisterEvent.save({
    required String name,
    required String email,
  }) = __RegisterEventSave;
  
}