import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:phone_book/domain/repositories/user_repository.dart';

import '../../../data/models/user.dart';
import '../../../root/theme/modals/dialogs.dart';

class RegistrationController extends GetxController {
  final UserRepository repository;

  final formKey = GlobalKey<FormState>();

  final usernameFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  RegistrationController({required this.repository});

  Future<void> registration() async {
    Dialog().loading();

    final user = User(
        username: usernameFieldController.text,
        passowrd: passwordFieldController.text);

    final successOrFailed = await repository.registration(user: user);

    Get.back();

    successOrFailed.fold(
      (errMessage) {
        Get.snackbar('Failed', errMessage);
      },
      (success) {
        Get.back(result: {
          'data': true,
          'message': success
        });
        clearForm();
      },
    );
  }

  void clearForm() {
    usernameFieldController.clear();
    passwordFieldController.clear();
  }
}
