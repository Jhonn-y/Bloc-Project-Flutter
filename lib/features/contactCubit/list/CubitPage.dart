import 'package:bloc_project/features/contactCubit/list/cubit/listCubit.dart';
import 'package:bloc_project/features/contactCubit/update/cubit/updateCubit.dart';
import 'package:bloc_project/features/loader.dart';
import 'package:bloc_project/models/contactModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactCubitPage extends StatelessWidget {
  const ContactCubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cubit Contact'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await Navigator.of(context).pushNamed('contact/list/cubit/register');
        context.read<ListCubit>().findAll();
      }),
      body: RefreshIndicator(
        onRefresh: () {
          return context.read<ListCubit>().findAll();
        },
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Column(
                children: [
                  Loader<ListCubit,ListCubitState>(selector: (state){
                    return state.maybeWhen(
                      loading: () => true,
                      orElse: () => false);
                  }),
                  BlocSelector<ListCubit,ListCubitState,List<ContactModel>>(selector: (state){
                    return state.maybeWhen(
                      data: (contacts) => contacts,
                      orElse: () =>  []
                    );
                  }, builder: (context, state) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.length,
                      itemBuilder: (_, index) {
                        final contact = state[index];
                        return ListTile(
                          title: Text(contact.name),
                          subtitle: Text(contact.email),
                          onTap: () async {
                            await Navigator.of(context).pushNamed('contact/list/cubit/update',arguments: contact);
                            context.read<ListCubit>().findAll();
                          },
                          onLongPress: () => {
                            context.read<ListCubit>().delete(contact),  
                          }, // Add your onTap action here
                        );
                      
                    },);
                  },)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
