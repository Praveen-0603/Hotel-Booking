import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:hotel_booking/Models/hotel_model.dart';

class HotelDetailsController extends GetxController
    with SingleGetTickerProviderMixin {
  final HotelModel data = Get.arguments;

  late TabController tabcontroller;
  int currentTab = 0;

  File? image;

  getimage() async {
    final fileinfo =
        await DefaultCacheManager().getFileFromCache(data.hotelImage);
    image = fileinfo?.file;
    update();
  }

  @override
  void onInit() {
    getimage();
    tabcontroller = TabController(length: 3, vsync: this);
    super.onInit();
  }

  @override
  void dispose() {
    tabcontroller.dispose();
    super.dispose();
  }

  changetab(value) {
    currentTab = value;
    update();
  }
}
