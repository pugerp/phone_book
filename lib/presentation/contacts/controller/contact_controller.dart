import 'package:get/get.dart';
import 'package:phone_book/data/models/contact.dart';
import 'package:phone_book/domain/repositories/contacts_repository.dart';
import 'package:phone_book/domain/repositories/user_repository.dart';
import 'package:phone_book/root/di/injections.dart';
import 'package:phone_book/root/router/router.dart';
import 'package:phone_book/root/theme/modals/dialogs.dart';
import 'package:phone_book/root/utilities/common/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactController extends GetxController with StateMixin<List<Contact>> {
  final ContactsRepository repository;
  final SharedPreferences sp;

  ContactController({required this.repository, required this.sp});

  Future<void> loadContacts() async {
    change(state, status: RxStatus.loading());

    final successOrFailed = await repository.fetchContacts();

    successOrFailed.fold(
      (errMessage) => change(state, status: RxStatus.error(errMessage)),
      (data) {
        if (data.isEmpty) {
          change(state, status: RxStatus.empty());
        } else {
          change(data, status: RxStatus.success());
        }
      }
    );
  }

  Future<void> logout() async {
    Dialog().loading();

    final result = await sp.remove(Constants.pref_key_user_id);

    if (!result) {
      Get.snackbar('Failed', 'Logout is Failed');
      return;
    }
    this.refresh();
    Get.offAllNamed(AppRouter.login);
  }
}
