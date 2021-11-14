import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_booking/Controllers/firebase_auth_controller.dart';
import 'package:hotel_booking/Screens/auth_wrapper.dart';
import 'onboarding_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final control = Get.find<FirebaseAuthController>();
    return (() {
      if (control.isFirstTime) {
        return const OnboardingScreen();
      } else {
        return const AuthWrapper();
      }
    }());
  }
}
