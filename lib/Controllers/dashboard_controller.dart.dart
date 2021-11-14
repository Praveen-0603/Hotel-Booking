import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hotel_booking/Controllers/cloud_firestore_controller.dart';
import 'package:hotel_booking/Controllers/firebase_auth_controller.dart';
import 'package:hotel_booking/Models/hotel_model.dart';
import 'package:hotel_booking/Models/user_model.dart';
import 'package:hotel_booking/Services/nearby_api.dart';
import 'package:hotel_booking/Services/popular_api.dart';

class DashBoardController extends GetxController {
  final searchcontroller = TextEditingController();

  Future<List<HotelModel>> getpopularhotels =
      PopularHotelsRepo.getpopularhotels();
  Future<List<HotelModel>> getnearbyhotels = NearbyHotelRepo.getnearbyhotels();

  Rx<UserModel> userdata = UserModel().obs;

  @override
  void onInit() {
    getusermodel();
    super.onInit();
  }

  Future<void> getusermodel() async {
    userdata.value = await CloudFirestoreController.getusermodel(
        Get.find<FirebaseAuthController>().user!.uid);
  }
}
