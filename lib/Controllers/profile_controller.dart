import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_booking/Controllers/cloud_firestore_controller.dart';
import 'package:hotel_booking/Controllers/dashboard_controller.dart.dart';
import 'package:hotel_booking/Controllers/firebase_auth_controller.dart';
import 'package:hotel_booking/Controllers/firebase_storage_controller.dart';
import 'package:hotel_booking/Controllers/homescreen_controller.dart';

class ProfileController extends GetxController {
  final TextEditingController changenametextctrl = TextEditingController();
  final TextEditingController checkpassword = TextEditingController();
  final TextEditingController firstnewpassctrl = TextEditingController();
  final TextEditingController secondnewpassctrl = TextEditingController();
  GlobalKey<FormState> firstpasskey = GlobalKey<FormState>();
  GlobalKey<FormState> secondpasskey = GlobalKey<FormState>();
  var autovalid = AutovalidateMode.disabled.obs;
  var taponchangename = false.obs;
  var formstate = 'DEFAULT'.obs;
  var profileurl = Get.find<HomeScreenController>().profileurl;
  var newpassword = '';
  var newpassword2 = '';
  var currentpassstatus = false.obs;
  var passwordvalid = false.obs;
  var loading = false.obs;
  var userdata = Get.find<DashBoardController>().userdata;

  Future<void> getprofileurl() async {
    profileurl.value = await FireBaseStorageController().getdownloadurl();
  }

  Future<void> changename(String? uid, String newname) async {
    await CloudFirestoreController.updateusername(uid, newname);
    taponchangename.value = false;
    await Get.find<DashBoardController>().getusermodel();
    clear();
  }

  String? checknewpass(String value) {
    if (value.length < 6) {
      return 'Password must be of 6 characters';
    } else {
      passwordvalid(true);
    }
  }

  checkvalidation() {
    final valid = firstpasskey.currentState!.validate();
    if (valid) {
      firstpasskey.currentState!.save();
      autovalid(AutovalidateMode.disabled);
      return true;
    } else {
      autovalid(AutovalidateMode.onUserInteraction);
      return false;
    }
  }

  String? checknewpassmatch(String newpass) {
    if (newpass == newpassword) {
      passwordvalid(true);
    } else {
      return 'Enter same Password';
    }
  }

  checkvalidationagain() {
    var valid = secondpasskey.currentState!.validate();
    if (valid) {
      secondpasskey.currentState!.save();
      return true;
    } else {
      autovalid(AutovalidateMode.onUserInteraction);
      return false;
    }
  }

  Future validatepassword(password) async {
    try {
      loading(true);
      await Get.find<FirebaseAuthController>().checkpassword(password);
      loading(false);
      return currentpassstatus(true);
    } catch (e) {
      loading(false);
      Get.snackbar('Error', e.toString());
      return currentpassstatus(false);
    }
  }

  void updatepassword(String newpass) async {
    try {
      WidgetsBinding.instance!.focusManager.primaryFocus!.unfocus();
      loading(true);
      await Get.find<FirebaseAuthController>().updatepassword(newpass);
      Get.snackbar('Success', 'Password Updated',
          snackPosition: SnackPosition.TOP);
      loading(false);
    } catch (e) {
      loading(false);
      WidgetsBinding.instance!.focusManager.primaryFocus!.canRequestFocus;
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.TOP);
    }
  }

  void clear() {
    changenametextctrl.text = '';
    checkpassword.text = '';
    firstnewpassctrl.text = '';
    secondnewpassctrl.text = '';
  }

  @override
  void dispose() {
    changenametextctrl.dispose();
    checkpassword.dispose();
    firstnewpassctrl.dispose();
    secondnewpassctrl.dispose();
    super.dispose();
  }
}
