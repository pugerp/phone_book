import 'package:get/get.dart';
import 'package:phone_book/root/router/router.dart';
import 'package:phone_book/root/utilities/common/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final SharedPreferences sp;

  SplashController({required this.sp});

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 3));
    var result = sp.getString(Constants.pref_key_user_id);

    if (result == null || result.isEmpty) {
      Get.offNamed(AppRouter.login);
    } else {
      Get.offNamed(AppRouter.contacts);
    }
  }
}
