import 'package:get/get.dart';
import 'package:phone_book/domain/repositories/contacts_repository.dart';
import 'package:phone_book/presentation/contacts/controller/contact_controller.dart';

import '../../../data/models/contact.dart';
import '../../../root/theme/modals/dialogs.dart';

class ContactDetailsController extends GetxController {
  final ContactsRepository repository;

  var contact = Contact(name: '', phone: '', email: '', userId: '').obs;

  ContactDetailsController({required this.repository});

  Future<void> deleteContact(contactId) async {
    Dialog().loading();

    final successOrFailed =
        await repository.deleteContact(contactId: contactId);

    Get.back();

    successOrFailed.fold((errMessage) {
      Get.snackbar('Failed', errMessage);
    }, (success) {
      Get.find<ContactController>().loadContacts();
      Get.back();
      Get.snackbar('Success', success);
    });
  }
}
