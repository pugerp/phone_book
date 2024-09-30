import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phone_book/data/models/contact.dart';
import 'package:phone_book/presentation/contacts/controller/contact_controller.dart';
import 'package:phone_book/root/router/router.dart';
import 'package:phone_book/root/theme/modals/bottomsheets.dart';
import 'package:phone_book/root/utilities/common/extensions.dart';

class ContactsView extends StatelessWidget {
  ContactsView({super.key});

  final controller = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          GestureDetector(
            onTap: () => handleAddContact(controller),
            child: const Icon(
              Icons.add_circle_outline_rounded,
              size: 24,
            ),
          ).paddingOnly(right: 16),
          GestureDetector(
            onTap: () async {
              var result = await CustomBottmsheet.confirmSheet(
                title: 'Logout',
                iconSheet: Icons.logout_rounded,
                confirmationText: 'Are you sure you want to log out?',
                positiveTap: () => Get.back(result: true),
                negativeTap: () => Get.back(result: false),
              );

              if (result == null || !result) {
                return;
              }

              controller.logout();
            },
            child: const Icon(
              Icons.logout_rounded,
              size: 24,
            ),
          ).paddingOnly(right: 16),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: GetBuilder<ContactController>(
                init: controller..loadContacts(),
                builder: (c) {
                  return c.obx((contacts) => handleSuccess(context, contacts!),
                      onLoading: handleLoading(),
                      onError: (error) => handleError(
                          error ?? 'Something Error While Fetching'),
                      onEmpty: handleEmpty(c));
                },
              ),
            ),
          ),
        ],
      ).paddingAll(16),
    );
  }
}

void handleAddContact(ContactController controller) async {
  var result = await Get.toNamed(AppRouter.contact_form);

  if (result == null || result['data'] == null) {
    return;
  }

  final newContact = result['data'];
  final message = result['message'];

  controller.loadContacts();

  Get.snackbar('Success', message);
}

Widget handleEmpty(ContactController controller) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        width: 0.5.sw,
        child: const Text(
          'There are no any saved contacts yet',
          textAlign: TextAlign.center,
        ),
      ),
      8.verticalSpace,
      ElevatedButton(
          onPressed: () => handleAddContact(controller),
          child: const Text('Add contact'))
    ],
  );
}

Widget handleSuccess(BuildContext context, List<Contact> contacts) {
  return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16.w),
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return itemContact(
          contact,
          () {
            // Get.toNamed(AppRouter.contact_form, arguments: contact);
            Get.toNamed(AppRouter.contact_detail, arguments: contact);
          },
        );
      },
      separatorBuilder: (_, __) => 16.verticalSpace,
      itemCount: contacts.length);
}

Widget itemContact(Contact contact, Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: ShapeDecoration(
        color: Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 0.12.sw,
            height: 0.12.sw,
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              color: Colors.grey[500],
            ),
            child: Center(
              child: Text(
                contact.name.initials,
                style: TextStyle(color: Colors.white, fontSize: 20.sp),
              ),
            ),
          ),
          16.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(contact.name),
              4.verticalSpace,
              Text('+62${contact.phone}')
            ],
          ),
          const Spacer(),
          const Icon(Icons.more_horiz_outlined)
        ],
      ).paddingSymmetric(
        vertical: 8,
        horizontal: 16,
      ),
    ),
  );
}

Widget handleLoading() => const CircularProgressIndicator();

Widget handleError(String errMessage) => Text(errMessage);
