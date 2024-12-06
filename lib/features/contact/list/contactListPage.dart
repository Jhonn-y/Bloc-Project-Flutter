import 'package:bloc_project/features/contact/list/bloc/contactBloc.dart';
import 'package:bloc_project/features/contact/register/bloc/registerBloc.dart';
import 'package:bloc_project/features/loader.dart';
import 'package:bloc_project/models/contactModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {

        await Navigator.of(context).pushNamed('contact/register');
        context.read<ContactBloc>().add( ContactEvent.findAll());
      },
      child: const Icon(Icons.add),
      ),
      body: BlocListener<ContactBloc, ContactState>(
        listenWhen: (previous, current) {
            return current.maybeWhen(
              error: (error) => true,
              orElse: () => false,);
        },
        listener: (context, state) {
          state.whenOrNull(error: (error) {
            return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error,
                style: const TextStyle( color:  Colors.red),),
                backgroundColor: Colors.red,
              ),
            );
          });
        },
        child: RefreshIndicator(
          onRefresh: () async => context.read<ContactBloc>()..add(ContactEvent.findAll()),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Column(
                  children: [
                    Loader<ContactBloc, ContactState>(
                      selector: (state) {
                        return state.maybeWhen(
                          loading: () => true,
                          orElse: ()=> false);
                      },
                    ),
                    BlocSelector<ContactBloc, ContactState, List<ContactModel>>(
                      selector: (state) {
                        return state.maybeWhen(
                          data: (contacts) => contacts,
                          orElse: () => [],
                        );
                      },
                      builder: (_, contacts) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            final contact = contacts[index];
                            return Dismissible(
                              key: ValueKey(contact.id),
                              onDismissed: (direction) {
                                context.read<ContactBloc>().add(ContactEvent.delete(model: contact));
                              },
                              direction: DismissDirection.endToStart,
                              child: ListTile(
                                title: Text(contact.name),
                                subtitle: Text(contact.email),
                                onTap: () async {
                                  await Navigator.of(context).pushNamed('contact/update', arguments: contact);
                                  context.read<ContactBloc>().add(ContactEvent.findAll());
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
