import 'package:get/get.dart';
import 'package:hotel_booking/Controllers/cloud_firestore_controller.dart';
import 'package:hotel_booking/Controllers/firebase_auth_controller.dart';
import 'package:hotel_booking/Models/mybookings_model.dart';

class MyBookingController extends GetxController {
  List<MyBookingModel> upcoming = [];
  List<MyBookingModel> completed = [];

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
  void onInit() async {
    super.onInit();
    await getmybookings();
  }

  Future<List<MyBookingModel>> getmybookings() async {
    return await CloudFirestoreController.getmybookings(
        uid: Get.find<FirebaseAuthController>().user!.uid);
  }
}
