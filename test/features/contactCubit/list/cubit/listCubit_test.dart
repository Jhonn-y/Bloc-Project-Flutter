import 'package:bloc_project/features/contactCubit/list/cubit/listCubit.dart';
import 'package:bloc_project/models/contactModel.dart';
import 'package:bloc_project/repo/contactRepo.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockContactBloc extends Mock implements ContactRepo {}

void main() {
  late ContactRepo repo;
  late ListCubit cubit;
  late List<ContactModel> contacts;

  setUp(() {
    repo = MockContactBloc();
    cubit = ListCubit(repository: repo);
    contacts = [
      ContactModel(name: 'John Doe', email: 'john.doe@example.com'),
      ContactModel(name: 'Jane Doe', email: 'jane.doe@example.com')
    ];
  });

  blocTest<ListCubit, ListCubitState>(
    "Deve buscar os dados para a lista",
    build: () => cubit,
    act: (cubit) => cubit.findAll(),
    setUp: (){
      when(() => repo.findAll()).thenAnswer((_) async => (contacts));
    },
    expect: () => [
      ListCubitState.loading(),
      ListCubitState.data(model: contacts)
    ]
  );

  blocTest<ListCubit, ListCubitState>(
    "Deve retornar erro",
    build: () => cubit,
    act: (cubit) => cubit.findAll(),
    expect: () => [
      ListCubitState.loading(),
      ListCubitState.error(error: 'Erro ao buscar contatos!')
    ]
  );

}