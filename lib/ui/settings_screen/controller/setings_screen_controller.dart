import 'package:get/get.dart';

class SettingsScreenController extends GetxController {
  RxBool isAllowNotification = true.obs;
  RxBool darkMode = false.obs;

  void onChangedNotification(bool value) {
    isAllowNotification.value = value;
  }

  void onDarkModeChanged(bool value) {
    darkMode.value = value;
  }
}
