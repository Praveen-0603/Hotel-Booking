import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:hotel_booking/Controllers/firebase_auth_controller.dart';

class ForgotController extends GetxController {
  final TextEditingController emailcontroller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  AutovalidateMode validationmode = AutovalidateMode.disabled;

  String? validateEmail(String email) {
    if (!email.isEmail) {
      return 'Enter valid email';
    }
  }

  bool checkvalidation() {
    if (formkey.currentState!.validate()) {
      return true;
    } else {
      validationmode = AutovalidateMode.onUserInteraction;
      update();
      return false;
    }
  }

  Future<void> sendemail() async {
    if (checkvalidation()) {
      await Get.find<FirebaseAuthController>()
          .forgotpassword(email: emailcontroller.text);
      Get.back();
    }
  }
}
