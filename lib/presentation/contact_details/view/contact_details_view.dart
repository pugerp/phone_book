import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phone_book/presentation/contact_details/controller/contact_details_controller.dart';
import 'package:phone_book/presentation/contacts/controller/contact_controller.dart';
import 'package:phone_book/root/utilities/common/extensions.dart';

import '../../../data/models/contact.dart';
import '../../../root/router/router.dart';
import '../../../root/theme/modals/bottomsheets.dart';

class ContactDetailsView extends StatelessWidget {
  ContactDetailsView({super.key});

  final controller = Get.find<ContactDetailsController>();

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null && Get.arguments is Contact) {
      controller.contact.value = Get.arguments;
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () async {
              var result = await Get.toNamed(AppRouter.contact_form,
                  arguments: controller.contact.value);

              if (result == null || result['data'] == null) {
                return;
              }

              Contact newContact = result['data'];

              controller.contact.value = newContact;

              Get.find<ContactController>().loadContacts();

              Get.snackbar('Success', result['message']);
            },
            child: const Icon(
              Icons.edit_note_rounded,
              size: 32,
            ).paddingOnly(right: 16),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 0.17.sh,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 44, bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      color: Colors.grey[300],
                    ),
                    child: Obx(
                      () => Text(
                        controller.contact.value.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 0.25.sw,
                    height: 0.25.sw,
                    decoration: ShapeDecoration(
                      shape: const CircleBorder(),
                      color: Colors.grey[500],
                    ),
                    child: Center(
                      child: Text(
                        controller.contact.value.name.initials,
                        style: TextStyle(color: Colors.white, fontSize: 32.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpace,
          Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                color: Colors.grey[300],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() =>
                      detailItem('Phone', controller.contact.value.phone)),
                  const Divider(),
                  Obx(() =>
                      detailItem('Email', controller.contact.value.email)),
                ],
              )),
          4.verticalSpace,
          SizedBox(
            width: 0.5.sw,
            child: TextButton(
              onPressed: () async {
                var result = await CustomBottmsheet.confirmSheet(
                  title: 'Delete Contact',
                  iconSheet: Icons.delete_outline_rounded,
                  confirmationText: 'Do you want to delete your contact?',
                  positiveTap: () => Get.back(result: true),
                  negativeTap: () => Get.back(result: false),
                );

                if (result == null || !result) {
                  return;
                }

                controller.deleteContact(controller.contact.value.id);
              },
              child: const Text(
                'Delete Contact',
                style: TextStyle(color: Colors.red),
              ),
            ),
          )
        ],
      ).paddingAll(8.0),
    );
  }

  Container deleteBottomSheet() {
    return Container(
      width: double.infinity,
      height: 0.35.sh,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16.r),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const Icon(
              Icons.delete_outline_rounded,
              size: 76,
            ),
            8.verticalSpace,
            Text(
              'Delete Contact',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text('Do you want to delete your contact?'),
            32.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Get.back(result: false);
                    },
                    child: Text('Cancel'),
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back(result: true);
                    },
                    child: Text('Delete'),
                  ),
                ),
              ],
            )
          ],
        ).paddingAll(16),
      ),
    );
  }

  Widget detailItem(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.capitalize!,
          style: TextStyle(fontSize: 10.sp),
        ),
        4.verticalSpace,
        Text(content)
      ],
    );
  }
}
