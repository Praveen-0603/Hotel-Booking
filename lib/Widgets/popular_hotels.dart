import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/Constants/constants.dart';

class PopularHotelsWidget extends StatelessWidget {
  const PopularHotelsWidget(
      {Key? key,
      required this.image,
      required this.hotelname,
      required this.location,
      required this.price,
      required this.rating})
      : super(key: key);
  final String image;
  final String hotelname;
  final String location;
  final String price;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 310,
      width: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              errorWidget: (context, url, uri) => const Center(
                child: Icon(
                  Icons.error_outline_outlined,
                  color: Colors.red,
                ),
              ),
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              width: 200,
              height: 200,
              fit: BoxFit.cover,
              imageUrl: image,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              SizedBox(
                width: 125,
                child: Text(
                  hotelname,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.sourceSansPro(
                    textStyle: const TextStyle(
                      color: Constants.ksecondarycolor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.star,
                color: Colors.yellow.shade700,
                size: 20,
              ),
              const SizedBox(width: 5),
              Text(
                rating,
                style: GoogleFonts.sourceSansPro(
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            location,
            style: GoogleFonts.sourceSansPro(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              text: '\$$price/',
              style: GoogleFonts.sourceSansPro(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Constants.kprimarycolor,
                ),
              ),
              children: const [
                TextSpan(
                  text: 'per night',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
