import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:phone_book/data/models/contact.dart';
import 'package:phone_book/root/utilities/common/constants.dart';
import 'package:phone_book/root/utilities/services/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ContactsRemoteDatasource {
  Future<List<Contact>> contacts();

  Future<void> add(Contact data);

  Future<void> update({required Contact data, required String contactId});

  Future<void> remove({required String contactId});
}

class ContactRemoteDatasourceImpl extends ContactsRemoteDatasource {
  final DatabaseService service;
  final SharedPreferences sp;

  ContactRemoteDatasourceImpl({required this.service, required this.sp});

  @override
  Future<void> add(Contact data) async => await service.contactRef.add(data);

  @override
  Future<void> remove({required String contactId}) async =>
      await service.contactRef.doc(contactId).delete();

  @override
  Future<List<Contact>> contacts() async {
    final response = await service.contactRef
        .where('userId', isEqualTo: sp.getString(Constants.pref_key_user_id))
        .get();

    return response.docs.map((doc) => doc.data() as Contact).toList();
  }

  @override
  Future<void> update(
          {required Contact data, required String contactId}) async =>
      await service.contactRef.doc(contactId).set(data);
}
