import 'package:get/get.dart';
import 'package:hotel_booking/Controllers/firebase_auth_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirebaseAuthController(), fenix: true);
  }
}
