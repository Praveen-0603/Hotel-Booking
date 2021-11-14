import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hotel_booking/Controllers/cloud_firestore_controller.dart';
import 'package:hotel_booking/Models/user_model.dart';
import 'package:hotel_booking/Screens/home_screen.dart';
import 'package:hotel_booking/Screens/login_screen.dart';

class FirebaseAuthController extends GetxController {
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  // ignore: prefer_final_fields
  Rx<User?> _user = FirebaseAuth.instance.currentUser.obs;
  User? get user => _user.value;
  final getstorage = GetStorage();
  bool isFirstTime = true;

  @override
  void onInit() {
    _user.bindStream(_firebase.authStateChanges());
    getstorage.writeIfNull('isFirstTime', true);
    isFirstTime = getstorage.read('isFirstTime');
    super.onInit();
  }

  Future<void> createuser(
      {required String email,
      required String password,
      required String name}) async {
    try {
      await _firebase.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = UserModel(
        email: email,
        name: name,
      );
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Get.offAll(() => const HomeScreen());
      });
      await CloudFirestoreController.createnewuser(user);
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(
        GetBar(
          snackStyle: SnackStyle.FLOATING,
          message: e.message,
          backgroundColor: Colors.red,
          duration: 2.seconds,
        ),
      );
    }
  }

  Future<void> loginuser(
      {required String email, required String password}) async {
    try {
      await _firebase.signInWithEmailAndPassword(
          email: email, password: password);
      // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Get.offAll(() => const HomeScreen());
      // });
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(
        GetBar(
          snackStyle: SnackStyle.FLOATING,
          message: e.message,
          backgroundColor: Colors.red,
          duration: 2.seconds,
        ),
      );
    }
  }

  Future<void> logout() async {
    try {
      await _firebase.signOut();
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Get.offAll(() => const LoginScreen());
      });
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(
        GetBar(
          snackStyle: SnackStyle.FLOATING,
          message: e.message,
          backgroundColor: Colors.red,
          duration: 2.seconds,
        ),
      );
    }
  }

  Future<void> forgotpassword({required String email}) async {
    try {
      await _firebase.sendPasswordResetEmail(email: email);
      Get.back();
      Get.showSnackbar(
        GetBar(
          snackStyle: SnackStyle.FLOATING,
          message: 'Reset mail sent successfully',
          backgroundColor: Colors.green,
          duration: 2.seconds,
        ),
      );
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(
        GetBar(
          snackStyle: SnackStyle.FLOATING,
          message: e.message,
          backgroundColor: Colors.red,
          duration: 2.seconds,
        ),
      );
    }
  }

  Future<void> updatepassword(String newpass) async {
    await user?.updatePassword(newpass);
    await logout();
  }

  Future<bool> checkpassword(String password) async {
    var credential = EmailAuthProvider.credential(
        email: user!.email.toString(), password: password);
    var passcheckresult = await user?.reauthenticateWithCredential(credential);
    return passcheckresult?.user != null;
  }
}
