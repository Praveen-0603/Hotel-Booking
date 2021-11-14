import 'dart:async';

import 'package:get/get.dart';

class OTPController extends GetxController {
  bool isResendAgain = true;
  bool isVerified = false;
  bool isLoading = false;

  String code = '';

  late Timer timer;
  int start = 60;

  @override
  void onInit() {
    resend();
    super.onInit();
  }

  void resend() {
    isResendAgain = true;
    update();
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      if (start == 0) {
        start = 60;
        isResendAgain = false;
        timer.cancel();
        update();
      } else {
        start--;
        update();
      }
    });
  }

  verify() {
    isLoading = true;
    update();
    const oneSec = Duration(milliseconds: 1000);
    timer = Timer.periodic(oneSec, (timer) {
      isLoading = false;
      isVerified = true;
      update();
    });
  }
}
