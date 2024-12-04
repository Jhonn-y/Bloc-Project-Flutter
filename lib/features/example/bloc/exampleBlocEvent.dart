part of "exampleBloc.dart";

@immutable
abstract class ExampleBlocEvent {}

class FindNameEvent extends ExampleBlocEvent {}

class AddNameEvent extends ExampleBlocEvent {
  final String name;
  AddNameEvent({
    required this.name,
  });
}

class RemoveNameEvent extends ExampleBlocEvent {
  final String name;
  RemoveNameEvent({
    required this.name,
  });
}
