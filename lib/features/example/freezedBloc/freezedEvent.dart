
part of "freezedBloc.dart";


@freezed
class FreezedEvent with _$FreezedEvent {
  factory FreezedEvent.findNames() = FreezedEventFindNames;
  factory FreezedEvent.addName(String name) = FreezedEventAddName;
  factory FreezedEvent.removeName(String name) = FreezedEventRemoveName;
  
}