import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phone_book/root/di/injections.dart';
import 'package:phone_book/root/router/router.dart';

class PhoneBook extends StatelessWidget {
  const PhoneBook({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      child: GetMaterialApp(
        title: 'Phone Book',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialBinding: Injections(),
        initialRoute: AppRouter.splash,
        getPages: AppRouter.pages,
      ),
    );
  }
}
