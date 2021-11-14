import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_booking/Controllers/firebase_auth_controller.dart';
import 'package:hotel_booking/Models/mybookings_model.dart';
import 'package:hotel_booking/Models/user_model.dart';

class CloudFirestoreController {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<bool> createnewuser(UserModel user) async {
    try {
      await _firestore
          .collection('users')
          .doc(Get.find<FirebaseAuthController>().user!.uid)
          .set({'name': user.name, 'email': user.email});
      return true;
    } on FirebaseException catch (e) {
      Get.snackbar('Error', e.message.toString());
      return false;
    }
  }

  static Future<UserModel> getusermodel(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection("users").doc(uid).get();
      return UserModel.fromDocumentSnapshot(doc);
    } on FirebaseException catch (e) {
      Get.showSnackbar(
        GetBar(
          snackStyle: SnackStyle.FLOATING,
          message: e.message,
          backgroundColor: Colors.red,
          duration: 2.seconds,
        ),
      );
      rethrow;
    }
  }

  static Future<void> updateusername(String? uid, String newname) async {
    try {
      await _firestore.collection('users').doc(uid).update({'name': newname});
      Get.showSnackbar(
        GetBar(
          snackStyle: SnackStyle.FLOATING,
          message: 'Username Changed',
          backgroundColor: Colors.green,
          duration: 1.seconds,
        ),
      );
    } on FirebaseException catch (e) {
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

  static Future<void> addbookings({
    required String uid,
    required dynamic data,
    required String address1,
    required String address2,
    required String phone,
    required DateTime checkin,
    required DateTime checkout,
    required String guests,
    required String rooms,
    required String price,
  }) async {
    try {
      _firestore.collection('users').doc(uid).collection('Mybookings').add({
        'data': data,
        'address1': address1,
        'address2': address2,
        'phone': phone,
        'Checkin': checkin,
        'Checkout': checkout,
        'Guest': guests,
        'Rooms': rooms,
        'Price': price,
      });
    } on FirebaseException catch (e) {
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

  static Future<List<MyBookingModel>> getmybookings(
      {required String uid}) async {
    List<MyBookingModel> mybookings = [];
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('Mybookings')
        .get()
        .then((value) {
      for (var element in value.docs) {
        mybookings.add(MyBookingModel.fromDocumnetSnapshot(element));
      }
      return mybookings;
    });
  }
}
