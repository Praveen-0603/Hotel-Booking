import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_booking/Controllers/firebase_auth_controller.dart';
import 'package:hotel_booking/Screens/home_screen.dart';
import 'package:hotel_booking/Screens/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final control = Get.find<FirebaseAuthController>();
    if (control.user != null) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}
