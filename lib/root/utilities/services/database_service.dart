import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phone_book/data/models/contact.dart';

import '../../../data/models/user.dart';

const String CONTACT_COLLECTION_REF = "contact";
const String USER_COLLECTION_REF = "user";

class DatabaseService {
  final FirebaseFirestore firestore;

  DatabaseService({required this.firestore});

  CollectionReference get contactRef =>
      firestore.collection(CONTACT_COLLECTION_REF).withConverter<Contact>(
            fromFirestore: (snapshot, _) =>
                Contact.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
            toFirestore: (contact, _) => contact.toJson(),
          );

  CollectionReference get userRef =>
      firestore.collection(USER_COLLECTION_REF).withConverter<User>(
            fromFirestore: (snapshot, _) =>
                User.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
            toFirestore: (user, _) => user.toJson(),
          );
}
