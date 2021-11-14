import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hotel_booking/Controllers/cloud_firestore_controller.dart';
import 'package:hotel_booking/Controllers/dashboard_controller.dart.dart';
import 'package:hotel_booking/Controllers/firebase_auth_controller.dart';
import 'package:hotel_booking/Keys/keys.dart';
import 'package:hotel_booking/Models/hotel_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ConfirmationController extends GetxController {
  final HotelModel arguments = Get.arguments;
  late Razorpay razorpay;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  Rx<AutovalidateMode> validationmode = AutovalidateMode.disabled.obs;
  late HotelModel data;
  final address1control = TextEditingController();
  final address2control = TextEditingController();
  final phonecontrol = TextEditingController();
  int days = 1;
  int price = 0;
  int guests = 2;
  int rooms = 1;
  File? image;
  DateTime? checkindate = DateTime.now();
  DateTime? checkoutdate = DateTime.now().add(1.days);
  TimeOfDay? checkintime = const TimeOfDay(hour: 9, minute: 00);
  TimeOfDay? checkouttime;
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  void onInit() {
    checkouttime = checkintime;
    data = arguments;
    _getimage();
    bookingprice();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlerExternalWallet);
  }

  void _handlerPaymentSuccess(PaymentSuccessResponse response) async {
    await _addbooking();
    Get.back();
    Get.back();
    Get.showSnackbar(
      GetBar(
        snackStyle: SnackStyle.FLOATING,
        message: 'Hotel Booked Successfully',
        backgroundColor: Colors.green,
        duration: 2.seconds,
      ),
    );
  }

  void _handlerErrorFailure(PaymentFailureResponse response) {
    Get.back();
    Get.showSnackbar(
      GetBar(
        snackStyle: SnackStyle.FLOATING,
        message: 'Operation Failed',
        backgroundColor: Colors.red,
        duration: 2.seconds,
      ),
    );
  }

  void _handlerExternalWallet(ExternalWalletResponse response) {}

  String? checkfileds(String value) {
    if (value.trim().isEmpty) {
      return "Enter required data";
    }
  }

  String? checkphone(String value) {
    if (!(value.trim().length == 10) && !value.trim().isPhoneNumber) {
      return 'Enter Valid Phone number';
    }
  }

  bool checkvalidation() {
    if (!key.currentState!.validate()) {
      validationmode.value = AutovalidateMode.onUserInteraction;
      return false;
    } else {
      return true;
    }
  }

  Future<void> _getimage() async {
    final fileinfo =
        await DefaultCacheManager().getFileFromCache(data.hotelImage);
    image = fileinfo?.file;
    update();
  }

  void bookingprice() {
    final int _price = int.parse(data.price);
    if (checkoutdate!.difference(checkindate!).inDays == 0) {
      days = checkoutdate!.difference(checkindate!).inDays + 1;
    } else if (checkoutdate!.difference(checkindate!).inDays == 1 &&
        checkoutdate!.difference(checkindate!).inHours > 24) {
      days = checkoutdate!.difference(checkindate!).inDays + 1;
    } else if (checkoutdate!.difference(checkindate!).inDays == 1) {
      days = checkoutdate!.difference(checkindate!).inDays;
    } else {
      days = checkoutdate!.difference(checkindate!).inDays + 1;
    }
    price = (days * _price) * rooms;
  }

  Future<void> _addbooking() async {
    await CloudFirestoreController.addbookings(
      uid: Get.find<FirebaseAuthController>().user!.uid,
      data: data.toJson(),
      address1: address1control.text,
      address2: address2control.text,
      phone: phonecontrol.text,
      checkin: checkindate!,
      checkout: checkoutdate!,
      guests: guests.toString(),
      rooms: rooms.toString(),
      price: price.toString(),
    );
  }

  void openCheckout() {
    var options = {
      "key": Keys.razorpaykey,
      "amount": price * 100,
      "name": "Hotel Booking App",
      "description": "Payment for booking ${data.hotelName} Hotel",
      "prefill": {
        "contact": phonecontrol.text,
        "email": Get.find<DashBoardController>().userdata.value.email
      },
      "external": {
        "wallets": ["paytm"]
      }
    };
    try {
      if (checkvalidation()) {
        razorpay.open(options);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }
}
