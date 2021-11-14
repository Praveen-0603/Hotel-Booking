import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/Constants/constants.dart';
import 'package:hotel_booking/Controllers/dashboard_controller.dart.dart';
import 'package:hotel_booking/Models/hotel_model.dart';
import 'package:hotel_booking/Utils/unfocusser.dart';
import 'package:hotel_booking/Widgets/near_hotels.dart';
import 'package:hotel_booking/Widgets/popular_hotels.dart';
import 'package:hotel_booking/Widgets/notification_icon.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final control = Get.put(DashBoardController());
    return Unfocuser(
      minScrollDistance: 0.0,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () {
                          return Text(
                            'Welcome, ${control.userdata.value.name ?? 'Mr.......'} !',
                            style: GoogleFonts.sourceSansPro(
                              textStyle: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        },
                      ),
                      NotificationIcon(
                        visible: true,
                        onTap: () {
                          Get.toNamed('Notifications');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Where do you want to stay?',
                    style: GoogleFonts.sourceSansPro(
                      textStyle: const TextStyle(
                        color: Constants.ksecondarycolor,
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 60,
                    child: TextField(
                      controller: control.searchcontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Search Destination',
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Places',
                        style: GoogleFonts.sourceSansPro(
                          textStyle: const TextStyle(
                            color: Constants.ksecondarycolor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.all(0),
                        ),
                        child: const Text('See all'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 310,
                    child: FutureBuilder<List<HotelModel>>(
                      future: control.getpopularhotels,
                      builder:
                          (context, AsyncSnapshot<List<HotelModel>> snapshot) {
                        if (snapshot.hasError) {
                          return const Icon(Icons.error_rounded,
                              color: Colors.red);
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.data == null ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('No Popular Hotels'),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed('HotelDetails',
                                      arguments: snapshot.data![index]);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: index == 0 ? 0 : 10),
                                  child: PopularHotelsWidget(
                                    image: snapshot.data![index].hotelImage,
                                    hotelname: snapshot.data![index].hotelName,
                                    location:
                                        snapshot.data![index].hotelLocation,
                                    price: snapshot.data![index].price,
                                    rating:
                                        snapshot.data![index].rating.toString(),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hotels Near You',
                        style: GoogleFonts.sourceSansPro(
                          textStyle: const TextStyle(
                            color: Constants.ksecondarycolor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.all(0),
                        ),
                        child: const Text('See all'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  FutureBuilder(
                    future: control.getnearbyhotels,
                    builder:
                        (context, AsyncSnapshot<List<HotelModel>> snapshot) {
                      if (snapshot.hasError) {
                        return const Icon(Icons.error_rounded,
                            color: Colors.red);
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No Popular Hotels'),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed('HotelDetails',
                                  arguments: snapshot.data![index]);
                            },
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: index == 0 ? 0 : 10),
                              child: NearHotelsWidget(
                                image: snapshot.data![index].hotelImage,
                                hotelname: snapshot.data![index].hotelName,
                                location: snapshot.data![index].hotelLocation,
                                price: snapshot.data![index].price,
                                rating: snapshot.data![index].rating.toString(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
