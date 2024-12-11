import 'package:bloc_project/features/contact/list/bloc/contactBloc.dart';
import 'package:bloc_project/models/contactModel.dart';
import 'package:bloc_project/repo/contactRepo.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/scaffolding.dart';


class MockContactBloc extends Mock implements ContactRepo {}

void main() {
  late ContactRepo repo;
  late ContactBloc bloc;
  late List<ContactModel> contacts;

  setUp(() {
    repo = MockContactBloc();
    bloc = ContactBloc(repository: repo);
    contacts = [
      ContactModel(name: 'John Doe', email: 'john.doe@example.com'),
      ContactModel(name: 'Jane Doe', email: 'jane.doe@example.com')
    ];
  });

  blocTest<ContactBloc, ContactState>(
    "Deve buscar os dados para a lista",
    build: () => bloc,
    act: (bloc) => bloc.add(ContactEvent.findAll()),
    setUp: (){
      when(() => repo.findAll()).thenAnswer((_) async => (contacts));
    },
    expect: () => [
      ContactState.loading(),
      ContactState.data(contacts: contacts)
    ]
  );
  blocTest<ContactBloc, ContactState>(
  "Deve retornar erro",
  build: () => bloc,
  act: (bloc) => bloc.add(ContactEvent.findAll()),
  expect: () => [
    ContactState.loading(),
    ContactState.error(errorMessage: 'Erro ao buscar contatos!') 
  ]
);

}
