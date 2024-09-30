import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:phone_book/domain/repositories/user_repository.dart';
import 'package:phone_book/root/theme/modals/dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../root/router/router.dart';
import '../../../root/utilities/common/constants.dart';

class LoginController extends GetxController {
  final UserRepository repository;
  final SharedPreferences sp;

  final formKey = GlobalKey<FormState>();
  final usernameFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  LoginController({required this.repository, required this.sp});

  Future<void> login() async {
    Dialog().loading();

    final successOrFailed = await repository.login(
      username: usernameFieldController.text,
      password: passwordFieldController.text,
    );

    Get.back();

    successOrFailed.fold(
      (errMessage) {
        Get.snackbar('Failed', errMessage);
      },
      (success) async {
        var saved = await sp.setString(Constants.pref_key_user_id, success.id!);

        if (!saved) {
          Get.snackbar('Failed', 'Error on Store Data');
          return;
        }

        Get.offNamed(AppRouter.contacts);
        Get.snackbar('Success', 'Hi, ${success.username}');
        clearForm();
      },
    );
  }

  void clearForm() {
    usernameFieldController.clear();
    passwordFieldController.clear();
  }
}
