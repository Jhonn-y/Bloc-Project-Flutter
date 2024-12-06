
import 'package:bloc_project/models/contactModel.dart';
import 'package:dio/dio.dart';

class ContactRepo {
  Future<List<ContactModel>> findAll() async {
    final response = await Dio().get('http://10.0.2.2:3031/contact');

    return response.data?.map<ContactModel>((contact) => ContactModel.fromMap(contact)).toList();
  }

  Future<void> create(ContactModel model) =>
    Dio().post('http://10.0.2.2:3031/contact', data: model.toMap());

  Future<void> update(ContactModel model) async =>
    Dio().put('http://10.0.2.2:3031/contact/${model.id}', data: model.toMap());

  Future<void> delete(ContactModel model) async => Dio().delete('http://10.0.2.2:3031/contact/${model.id}');
}