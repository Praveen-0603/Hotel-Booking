import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/Constants/constants.dart';

class NearHotelsWidget extends StatelessWidget {
  const NearHotelsWidget({
    Key? key,
    required this.image,
    required this.hotelname,
    required this.location,
    required this.price,
    required this.rating,
  }) : super(key: key);
  final String image;
  final String hotelname;
  final String location;
  final String price;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 181,
      padding: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      child: Row(
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
              width: MediaQuery.of(context).size.width * 0.4,
              height: 160,
              fit: BoxFit.cover,
              imageUrl: image,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          SizedBox(
            height: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.43,
                  child: Row(
                    children: [
                      Text(
                        'HOTEL',
                        style: GoogleFonts.sourceSansPro(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800,
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
                ),
                const SizedBox(height: 10),
                Text(
                  hotelname,
                  style: GoogleFonts.sourceSansPro(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Constants.ksecondarycolor,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on_sharp,
                      size: 16,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      location,
                      style: GoogleFonts.sourceSansPro(
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
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
                    // const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      // Text(
      //   hotelname,
      //   style: GoogleFonts.sourceSansPro(
      //     textStyle: const TextStyle(
      //       fontSize: 20,
      //       fontWeight: FontWeight.w600,
      //       color: Constants.ksecondarycolor,
      //     ),
      //   ),
      // ),
      // const SizedBox(height: 5),
      // Text(
      //   location,
      //   style: GoogleFonts.sourceSansPro(
      //     textStyle: TextStyle(
      //       fontSize: 16,
      //       fontWeight: FontWeight.w400,
      //       color: Colors.grey.shade800,
      //     ),
      //   ),
      // ),
      // const Spacer(),
      // Row(
      //   children: [
      //     RichText(
      //       text: TextSpan(
      //         text: '\$$price/',
      //         style: GoogleFonts.sourceSansPro(
      //           textStyle: const TextStyle(
      //             fontSize: 20,
      //             fontWeight: FontWeight.w600,
      //             color: Constants.kprimarycolor,
      //           ),
      //         ),
      //         children: const [
      //           TextSpan(
      //             text: 'per night',
      //             style: TextStyle(
      //               fontSize: 16,
      //               color: Colors.grey,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //     const Spacer(),
      //     Icon(
      //       Icons.star,
      //       color: Colors.yellow.shade700,
      //       size: 20,
      //     ),
      //     const SizedBox(width: 5),
      //     Text(
      //       rating,
      //       style: GoogleFonts.sourceSansPro(
      //         textStyle: const TextStyle(
      //           fontSize: 17,
      //           fontWeight: FontWeight.w400,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
