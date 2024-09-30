import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phone_book/root/theme/widgets/CustomField.dart';
import 'package:phone_book/root/utilities/validator/validation.dart';

import '../../../data/models/contact.dart';
import '../controller/contact_form_controller.dart';

class ContactFormView extends StatefulWidget {
  const ContactFormView({
    super.key,
  });

  @override
  State<ContactFormView> createState() => _ContactFormViewState();
}

class _ContactFormViewState extends State<ContactFormView> {
  final ContactFormController controller = Get.find<ContactFormController>();
  Contact? contact = Get.arguments;

  @override
  void initState() {
    super.initState();

    controller.clearForm();
    if (contact != null) {
      controller.nameFieldController.text = contact!.name;
      controller.emailFieldController.text = contact!.email;
      controller.phoneFieldController.text = contact!.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            CustomeField(
              controller: controller.nameFieldController,
              inputType: TextInputType.name,
              icon: Icons.person,
              title: 'Name',
              validators: const [
                RequiredValidation(),
              ],
            ),
            8.verticalSpace,
            CustomeField(
              controller: controller.phoneFieldController,
              inputType: TextInputType.phone,
              icon: Icons.phone,
              title: 'Phone',
              validators: const [
                RequiredValidation(),
              ],
            ),
            8.verticalSpace,
            CustomeField(
              controller: controller.emailFieldController,
              inputType: TextInputType.emailAddress,
              icon: Icons.email,
              title: 'Email',
              validators: const [
                RequiredValidation(),
                EmailValidation(),
              ],
            ),
            16.verticalSpace,
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.formKey.currentState!.save();
                    contact == null
                        ? controller.addContact()
                        : controller.updateContact(contactId: contact!.id!);
                  }
                },
                child: Text(contact != null ? 'Update' : 'Add'),
              ),
            ),
          ],
        ).paddingSymmetric(vertical: 32, horizontal: 16),
      ),
    );
  }
}
