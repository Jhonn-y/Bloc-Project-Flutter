
part of 'contactBloc.dart';


@freezed
class ContactEvent with _$ContactEvent {
  factory ContactEvent.findAll() = _ContactEventFindAll;
  factory ContactEvent.delete({required ContactModel model }) = _ContactEventDelete;

  
}