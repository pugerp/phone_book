import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phone_book/presentation/login/controller/login_controller.dart';
import 'package:phone_book/root/router/router.dart';
import 'package:phone_book/root/theme/widgets/CustomField.dart';
import 'package:phone_book/root/utilities/validator/validation.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.sp),
            ),
            24.verticalSpace,
            CustomeField(
                controller: controller.usernameFieldController,
                inputType: TextInputType.text,
                icon: Icons.person,
                title: 'Username',
                validators: const [RequiredValidation()]),
            8.verticalSpace,
            CustomeField(
                controller: controller.passwordFieldController,
                inputType: TextInputType.text,
                icon: Icons.lock,
                title: 'Password',
                isFieldPassword: true,
                validators: const [
                  RequiredValidation(),
                ]),
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        controller.login();
                      }
                    },
                    child: const Text('Login'),
                  ),
                ),
                16.horizontalSpace,
                TextButton(
                  onPressed: () async {
                    var result = await Get.toNamed(AppRouter.registration);

                    if (result == null || !(result['data'] as bool)) {
                      return;
                    }

                    Get.snackbar('Success', result['message']);
                  },
                  child: const Text('Registration'),
                ),
              ],
            ),
          ],
        ).paddingAll(16),
      ),
    );
  }
}
