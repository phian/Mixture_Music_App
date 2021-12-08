import 'package:get/get.dart';
import 'package:mixture_music_app/controllers/auth_controller.dart';

class AuthBinding implements Bindings {
  const AuthBinding();

  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
