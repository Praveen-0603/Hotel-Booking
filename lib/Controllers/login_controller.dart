import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'firebase_auth_controller.dart';

class LoginController extends GetxController {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool hidepass = true;
  RxBool loading = false.obs;
  AutovalidateMode validationmode = AutovalidateMode.disabled;

  Future<void> login() async {
    if (checkvalidation()) {
      loading(true);
      await Get.find<FirebaseAuthController>().loginuser(
          email: emailcontroller.text, password: passwordcontroller.text);
      loading(false);
    }
  }

  String? validateEmail(String email) {
    if (!email.isEmail) {
      return 'Enter valid email';
    }
  }

  String? validatePassword(String password) {
    if (password.length < 6) {
      return 'Password must be of 6 characters';
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

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }
}
