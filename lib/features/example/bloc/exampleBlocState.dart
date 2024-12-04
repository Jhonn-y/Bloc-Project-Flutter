part of "exampleBloc.dart";

@immutable
abstract class ExampleBlocState {}

class InitialState implements ExampleBlocState {}

class StateData implements ExampleBlocState {
  final List<String> names;

  StateData({
    required this.names,
  });
}
