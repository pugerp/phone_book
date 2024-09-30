import 'package:dartz/dartz.dart';
import 'package:phone_book/data/models/contact.dart';

abstract class ContactsRepository {
  Future<Either<String, List<Contact>>> fetchContacts();
  Future<Either<String, String>> addContact({required Contact data});
  Future<Either<String, String>> updateContact({required Contact data, required String contactId});
  Future<Either<String, String>> deleteContact({required String contactId});
}