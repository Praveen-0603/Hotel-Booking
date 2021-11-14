import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/Constants/constants.dart';
import 'package:hotel_booking/Controllers/mybooking_controller.dart';
import 'package:hotel_booking/Models/mybookings_model.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final control = Get.put(MyBookingController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Bookings',
          style: GoogleFonts.sourceSansPro(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: FutureBuilder<List<MyBookingModel>>(
          future: control.getmybookings(),
          builder: (context, AsyncSnapshot<List<MyBookingModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No Bookings'),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: MyBookingsWidget(
                      url: snapshot.data![index].hotelModel!.hotelImage,
                      price: snapshot.data![index].price!,
                      name: snapshot.data![index].hotelModel!.hotelName,
                      city: snapshot.data![index].hotelModel!.hotelLocation,
                      checkin: snapshot.data![index].checkin!.toDate(),
                      checkout: snapshot.data![index].checkout!.toDate(),
                      months: control.months,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class MyBookingsWidget extends StatelessWidget {
  const MyBookingsWidget({
    Key? key,
    required this.url,
    required this.price,
    required this.name,
    required this.city,
    required this.checkin,
    required this.checkout,
    this.months,
  }) : super(key: key);
  final String url;
  final String price;
  final String name;
  final String city;
  final DateTime checkin;
  final DateTime checkout;
  final dynamic months;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 350,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.shade200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 220,
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: GoogleFonts.sourceSansPro(
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Constants.kprimarycolor,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on_sharp,
                      size: 18,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      city,
                      style: GoogleFonts.sourceSansPro(
                        textStyle: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Constants.ksecondarycolor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'In : ${checkin.day} ${months[checkin.month - 1]} ${checkin.year}',
                  style: GoogleFonts.sourceSansPro(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Constants.ksecondarycolor,
                    ),
                  ),
                ),
                Text(
                  'Out : ${checkout.day} ${months[checkout.month - 1]} ${checkout.year}',
                  style: GoogleFonts.sourceSansPro(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Constants.ksecondarycolor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Total Price - ',
                  style: GoogleFonts.sourceSansPro(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Constants.kprimarycolor,
                    ),
                  ),
                  children: [
                    TextSpan(text: '\$$price'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
