import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.phone,
              size: 52,
            ),
            24.verticalSpace,
            Text(
              'Phone Book',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
            )
          ],
        ),
      ),
    );
  }
}
