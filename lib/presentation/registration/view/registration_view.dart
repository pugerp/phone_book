import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phone_book/presentation/registration/controller/registration_controller.dart';
import 'package:phone_book/root/theme/widgets/CustomField.dart';
import 'package:phone_book/root/utilities/validator/validation.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final RegistrationController controller = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Registration',
                style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
              ),
              16.verticalSpace,
              CustomeField(
                controller: controller.usernameFieldController,
                inputType: TextInputType.text,
                icon: Icons.person,
                title: 'Username',
                validators: const [RequiredValidation()],
              ),
              16.verticalSpace,
              CustomeField(
                controller: controller.passwordFieldController,
                inputType: TextInputType.text,
                icon: Icons.lock,
                title: 'Password',
                isFieldPassword: true,
                validators: const [
                  RequiredValidation(),
                  PasswordValidation(),
                ],
              ),
              16.verticalSpace,
              ElevatedButton(
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.formKey.currentState!.save();
                    controller.registration();
                  }
                },
                child: const Text('Registration'),
              ),
            ],
          ).paddingAll(16),
        ),
      ),
    );
  }
}
