import 'package:dartz/dartz.dart';
import 'package:phone_book/data/data_sources/remote/contacts_remote_datasource.dart';
import 'package:phone_book/data/models/contact.dart';
import 'package:phone_book/domain/repositories/contacts_repository.dart';

class ContactsRepositoryImpl extends ContactsRepository {
  final ContactsRemoteDatasource remote;

  ContactsRepositoryImpl({required this.remote});

  @override
  Future<Either<String, List<Contact>>> fetchContacts() async {
    try {
      final result = await remote.contacts();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> addContact({
    required Contact data
  }) async {
    try {
      final result = await remote.add(data);
      return const Right('Success Adding New Contact');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> deleteContact({required String contactId}) async {
    try {
      final result = await remote.remove(contactId: contactId);
      return const Right('Success Deleting Contact');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> updateContact({required Contact data, required String contactId}) async  {
    try {
      final result = await remote.update(contactId: contactId, data: data);
      return const Right('Success Updating Contact');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
