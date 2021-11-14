import 'package:get/get.dart';
import 'package:hotel_booking/Controllers/firebase_storage_controller.dart';
import 'package:hotel_booking/Controllers/notification_controller.dart';

class HomeScreenController extends GetxController {
  int currentscreen = 0;

  Rx<String> profileurl = ''.obs;

  @override
  void onInit() async {
    await getprofilepicture();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Get.put(NotificationController());
  }

  Future<void> getprofilepicture() async {
    profileurl.value = await FireBaseStorageController().getdownloadurl();
  }

  void changescreen(value) {
    currentscreen = value;
    update();
  }
}
