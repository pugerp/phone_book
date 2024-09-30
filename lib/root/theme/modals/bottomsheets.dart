import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomBottmsheet {
  static confirmSheet({
    IconData? iconSheet,
    required String title,
    required String confirmationText,
    String? negativeBtnLabel,
    String? positiveBtnLabel,
    required Function() positiveTap,
    required Function() negativeTap,
  }) {
    return Get.bottomSheet(Container(
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
            Icon(
              iconSheet,
              size: 76,
            ),
            8.verticalSpace,
            Text(
              title,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(confirmationText),
            32.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: negativeTap,
                    child: Text(negativeBtnLabel ?? 'Cancel'),
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: ElevatedButton(
                    onPressed: positiveTap,
                    child: Text(positiveBtnLabel ?? 'Confirm'),
                  ),
                ),
              ],
            )
          ],
        ).paddingAll(16),
      ),
    ));
  }
}
