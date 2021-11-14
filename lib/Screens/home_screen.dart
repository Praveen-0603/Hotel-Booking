import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_booking/Controllers/homescreen_controller.dart';
import 'package:hotel_booking/Screens/dash_board.dart';
import 'package:hotel_booking/Screens/offers_screen.dart';
import 'package:hotel_booking/Screens/profile_screen.dart';
import 'package:hotel_booking/Screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final control = Get.put(HomeScreenController());
    return GetBuilder<HomeScreenController>(builder: (_) {
      return Scaffold(
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: BottomNavyBar(
            selectedIndex: control.currentscreen,
            onItemSelected: (index) => control.changescreen(index),
            items: [
              BottomNavyBarItem(
                icon:
                    Image.asset('assets/icons/home.png', height: 24, width: 24),
                title: const Text(' Dashboard'),
                activeColor: Colors.red,
              ),
              BottomNavyBarItem(
                  icon: Image.asset('assets/icons/offers.png',
                      height: 24, width: 24),
                  title: const Text(' Offers'),
                  activeColor: Colors.purpleAccent),
              BottomNavyBarItem(
                  icon: Obx(
                    () {
                      return ClipOval(
                        child: control.profileurl.value != ''
                            ? CachedNetworkImage(
                                errorWidget: (context, url, uri) =>
                                    const Center(
                                  child: Icon(
                                    Icons.error_outline_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                imageUrl: control.profileurl.value,
                                height: 24,
                                width: 24,
                              )
                            : const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(),
                              ),
                      );
                    },
                  ),
                  title: const Text(' Profile'),
                  activeColor: Colors.blueAccent),
              BottomNavyBarItem(
                  icon: Image.asset('assets/icons/settings.png',
                      height: 24, width: 24),
                  title: const Text(' Settings'),
                  activeColor: Colors.blue),
            ],
          ),
        ),
        body: screens[control.currentscreen],
      );
    });
  }
}

List<Widget> screens = [
  const DashBoard(),
  OffersScreen(),
  const ProfileScreen(),
  const SettingScreen(),
];
