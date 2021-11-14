import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/Constants/constants.dart';
import 'package:hotel_booking/Controllers/confirmation_controller.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget(
      {Key? key,
      required this.title,
      required this.control,
      required this.subtitle,
      required this.ontap})
      : super(key: key);
  final String title;
  final String subtitle;
  final VoidCallback ontap;
  final ConfirmationController control;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.sourceSansPro(
            textStyle: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
        // const SizedBox(height: 5),
        Row(
          children: [
            Text(
              subtitle,
              style: GoogleFonts.sourceSansPro(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Constants.ksecondarycolor,
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: ontap,
              child: const Icon(Icons.keyboard_arrow_down_rounded, size: 34),
            ),
          ],
        ),
      ],
    );
  }
}
