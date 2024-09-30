import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:phone_book/data/data_sources/remote/contacts_remote_datasource.dart';
import 'package:phone_book/data/repositories/contacts_repository_impl.dart';
import 'package:phone_book/domain/repositories/contacts_repository.dart';
import 'package:phone_book/domain/repositories/user_repository.dart';
import 'package:phone_book/presentation/contact_details/controller/contact_details_controller.dart';
import 'package:phone_book/presentation/contact_form/controller/contact_form_controller.dart';
import 'package:phone_book/presentation/contacts/controller/contact_controller.dart';
import 'package:phone_book/presentation/login/controller/login_controller.dart';
import 'package:phone_book/presentation/registration/controller/registration_controller.dart';
import 'package:phone_book/presentation/splash/controller/splash_controller.dart';
import 'package:phone_book/root/utilities/services/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_sources/remote/user_remote_datasource.dart';
import '../../data/repositories/user_repository_impl.dart';

class Injections implements Bindings {
  @override
  void dependencies() async {
    //core
    final prefs = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(prefs, permanent: true);
    Get.put<FirebaseFirestore>(FirebaseFirestore.instance, permanent: true);
    Get.put<DatabaseService>(
        DatabaseService(firestore: Get.find<FirebaseFirestore>()),
        permanent: true);
    //datasources
    Get.lazyPut<ContactsRemoteDatasource>(() => ContactRemoteDatasourceImpl(
        service: Get.find<DatabaseService>(),
        sp: Get.find<SharedPreferences>()));
    Get.lazyPut<UserRemoteDatasource>(
        () => UserRemoteDatasourceImpl(service: Get.find<DatabaseService>()));
    //repositories
    Get.lazyPut<ContactsRepository>(() =>
        ContactsRepositoryImpl(remote: Get.find<ContactsRemoteDatasource>()));
    Get.lazyPut<UserRepository>(
        () => UserRepositoryImpl(remote: Get.find<UserRemoteDatasource>()));
    //usecases
    //controller
    Get.put(SplashController(sp: Get.find<SharedPreferences>()),
        permanent: true);
    Get.put(RegistrationController(repository: Get.find<UserRepository>()),
        permanent: true);
    Get.put(
        LoginController(
            repository: Get.find<UserRepository>(),
            sp: Get.find<SharedPreferences>()),
        permanent: true);
    Get.put(
        ContactController(
            repository: Get.find<ContactsRepository>(),
            sp: Get.find<SharedPreferences>()),
        permanent: true);
    Get.put(
        ContactFormController(
            repository: Get.find<ContactsRepository>(),
            sp: Get.find<SharedPreferences>()),
        permanent: true);
    Get.put(
        ContactDetailsController(repository: Get.find<ContactsRepository>()),
        permanent: true);
  }
}
