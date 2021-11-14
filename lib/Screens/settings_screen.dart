import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/Constants/constants.dart';
import 'package:hotel_booking/Controllers/notification_controller.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool val1 = true;
  onChangeFunction1(bool newValue1) {
    setState(() {
      val1 = newValue1;
      if (newValue1) {
        Get.find<NotificationController>().shownotification(
          id: 1,
          title: 'Success',
          body: 'Notifications are now enabled',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.sourceSansPro(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        titleSpacing: 10,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 13.0),
                child: Text(
                  'General',
                  style: GoogleFonts.sourceSansPro(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Constants.kprimarycolor,
                    ),
                  ),
                ),
              ),
              customSwitch('Enable notifications', val1, onChangeFunction1),
              // customSwitch('Dark Mode', val2, onChangeFunction2),
              const Divider(
                color: Constants.ksecondarycolor,
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: const Icon(Icons.security,
                    color: Constants.ksecondarycolor),
                title: const Text(
                  'Terms and Conditions',
                  style: TextStyle(color: Constants.ksecondarycolor),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Constants.ksecondarycolor,
                ),
                onTap: () {
                  Get.toNamed('Terms');
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: const Icon(
                  Icons.help_outline_outlined,
                  color: Constants.ksecondarycolor,
                ),
                title: const Text(
                  'About us',
                  style: TextStyle(color: Constants.ksecondarycolor),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Constants.ksecondarycolor,
                ),
                onTap: () {
                  aboutMyApp(context);
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

Widget customSwitch(String text, bool val, Function onChangeMethod) {
  return Padding(
    padding: const EdgeInsets.only(top: 7.0, left: 13.0, right: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: Constants.ksecondarycolor)),
        const Spacer(),
        CupertinoSwitch(
          trackColor: Constants.ksecondarycolor,
          activeColor: Constants.kprimarycolor,
          value: val,
          onChanged: (newValue) {
            onChangeMethod(newValue);
          },
        )
      ],
    ),
  );
}

void aboutMyApp(BuildContext context) {
  showAboutDialog(
    context: context,
    applicationIcon: const FlutterLogo(),
    applicationName: 'Hotel Booking',
    applicationVersion: '0.0.1',
    applicationLegalese: 'Developed by Team',
    children: <Widget>[
      const Text(
          'By investing in the technology that helps take the friction out of travel, Booking.com seamlessly connects millions of travellers with memorable experiences, a range of transport options and incredible places to stay - from homes to hotels and muchmore.'),
      const Text(
          'As one of the world’s largest travel marketplaces for both established brands and entrepreneurs of all sizes, Booking.com enables properties all over the world to reach a global audience and grow their businesses.'),
      const Text(
          'Booking.com is available in 43 languages and offers more than 28 million total reported accommodation listings, including over 6.2 million listings alone of homes, apartments and other unique places to stay. No matter where you want to go or what you want to do, Booking.com makes it easy and backs it all up with 24/7 customer support.'),
      const Text(
          'LOW RATES: Booking.com guarantees to offer you the best available rates. And with our promise to price match, you can rest assured that you’re always getting a great deal.'),
      const Text(
          'NO RESERVATION FEES: We don’t charge you any booking fees or add any administrative charges. And in many cases, your booking can be cancelled free of charge.'),
      const Text(
          '24/7 SUPPORT: Whether you’ve just booked or are already enjoying your trip, our customer experience team are on hand around the clock to answer your questions and advocate on your behalf in more than 40 languages. Make sure to check out our FAQ for travellers.')
    ],
  );
}
