import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_booking/Models/hotel_model.dart';
import 'package:hotel_booking/Widgets/popular_hotels.dart';

class PopularHotelsScreen extends StatelessWidget {
  PopularHotelsScreen({Key? key}) : super(key: key);

  final HotelModel data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return PopularHotelsWidget(
            image: data.hotelImage,
            hotelname: data.hotelName,
            location: data.hotelLocation,
            price: data.price,
            rating: data.price,
          );
        },
      ),
    );
  }
}
