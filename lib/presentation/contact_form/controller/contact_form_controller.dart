import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_book/data/models/contact.dart';
import 'package:phone_book/domain/repositories/contacts_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../root/theme/modals/dialogs.dart' as CustomDialog;

import '../../../root/utilities/common/constants.dart';

class ContactFormController extends GetxController {
  final ContactsRepository repository;
  final SharedPreferences sp;

  final formKey = GlobalKey<FormState>();

  final nameFieldController = TextEditingController();
  final emailFieldController = TextEditingController();
  final phoneFieldController = TextEditingController();

  ContactFormController({required this.repository, required this.sp});

  Future<void> addContact() async {
    final data = Contact(
      name: nameFieldController.text,
      email: emailFieldController.text,
      phone: phoneFieldController.text,
      userId: sp.getString(Constants.pref_key_user_id)!,
    );

    CustomDialog.Dialog().loading();

    final successOrFailed = await repository.addContact(data: data);

    Get.back();

    successOrFailed.fold((errMessage) {
      Get.snackbar('Failed', errMessage);
    }, (success) {
      Get.back(result: {'data': data, 'message': success});
      clearForm();
    });
  }

  Future<void> updateContact({required String contactId}) async {
    // final data = {
    //   "name": nameFieldController.text,
    //   "email": emailFieldController.text,
    //   "phone": phoneFieldController.text,
    // };

    final data = Contact(
      name: nameFieldController.text,
      email: emailFieldController.text,
      phone: phoneFieldController.text,
      userId: sp.getString(Constants.pref_key_user_id)!,
    );

    CustomDialog.Dialog().loading();

    final successOrFailed =
        await repository.updateContact(contactId: contactId, data: data);

    Get.back();

    successOrFailed.fold((errMessage) {
      Get.snackbar('Failed', errMessage);
    }, (success) {
      Get.back(
          result: {'data': data.copyWith(id: contactId), 'message': success});
      clearForm();
    });
  }

  void clearForm() {
    nameFieldController.clear();
    emailFieldController.clear();
    phoneFieldController.clear();
  }
}
