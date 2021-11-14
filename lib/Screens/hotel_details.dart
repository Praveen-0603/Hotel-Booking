import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/Constants/constants.dart';
import 'package:hotel_booking/Controllers/hoteldetails_controller.dart';

class HotelDetailsScreen extends StatelessWidget {
  const HotelDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final control = Get.put(HotelDetailsController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.54,
              child: _buildImage(context: context),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.51),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          control.data.hotelName,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.sourceSansPro(
                            textStyle: const TextStyle(
                              color: Constants.ksecondarycolor,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade700,
                          size: 22,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          control.data.rating.toString(),
                          style: GoogleFonts.sourceSansPro(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '(25)',
                          style: GoogleFonts.sourceSansPro(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 18, color: Colors.blueAccent),
                        const SizedBox(width: 5),
                        Text(
                          control.data.hotelLocation,
                          style: GoogleFonts.sourceSansPro(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Details',
                      style: GoogleFonts.sourceSansPro(
                        textStyle: const TextStyle(
                          color: Constants.ksecondarycolor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildDetails(),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 100,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: _facilities
                            .map((name, icon) => MapEntry(name,
                                _buildFacilitiesTile(name: name, icon: icon)))
                            .values
                            .toList(),
                      ),
                    ),
                    TabBar(
                      controller: control.tabcontroller,
                      onTap: (value) {
                        control.changetab(value);
                      },
                      tabs: const [
                        Tab(
                          child: Text(
                            'Description',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Location',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Reviews',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GetBuilder<HotelDetailsController>(
                      builder: (_) {
                        return control.currentTab == 0
                            ? _buildDescription()
                            : control.currentTab == 1
                                ? _buildlocation(context)
                                : control.currentTab == 2
                                    ? _buildreviews(control)
                                    : const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 70,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Row(
            children: [
              RichText(
                text: TextSpan(
                  text: '\$${control.data.price}/',
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
              const Spacer(),
              MaterialButton(
                height: 60,
                color: Constants.kprimarycolor,
                minWidth: MediaQuery.of(context).size.width * 0.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  "Book Now",
                  style: GoogleFonts.sourceSansPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                onPressed: () {
                  Get.toNamed('ConfirmationPage', arguments: control.data);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_buildDescription() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      'A hotel is an establishment that provides paid lodging on a short-term basis.Hotel rooms are usually numbered (or named in some smaller hotels and B&Bs) to allow guests to identify their room. Some boutique, high-end hotels have custom decorated rooms. Some hotels offer meals as part of a room and board arrangement.',
      style: TextStyle(
        color: Colors.grey.shade800,
        fontSize: 15,
      ),
    ),
  );
}

_buildlocation(BuildContext context) {
  return SizedBox(
    height: 250,
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          errorWidget: (context, url, uri) => const Center(
            child: Icon(Icons.error_outline_outlined, color: Colors.red),
          ),
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          imageUrl:
              'https://docs.microsoft.com/en-us/azure/azure-maps/media/migrate-google-maps-web-app/google-maps-marker.png',
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

_buildreviews(control) {
  return ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    minRadius: 12,
                    child: Icon(Icons.person),
                    backgroundColor: Constants.kprimarycolor,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Micheal',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.star,
                    color: Colors.yellow.shade700,
                    size: 22,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    control.data.rating.toString(),
                    style: GoogleFonts.sourceSansPro(
                      textStyle: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'They were extremely accommodating and allowed us to check in early at like 10am. We got to hotel super early and I didn’t wanna wait. So this was a big plus. The sevice was exceptional as well. Would definitely send a friend there',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        );
      });
}

_buildImage({required BuildContext context}) {
  return Stack(
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.54,
        width: MediaQuery.of(context).size.width,
        child: GetBuilder<HotelDetailsController>(builder: (control) {
          return control.image == null
              ? const Center(child: CircularProgressIndicator())
              : Image.file(control.image!, fit: BoxFit.cover);
        }),
      ),
      Positioned(
        top: 15 + MediaQuery.of(context).padding.top,
        left: 15,
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      Positioned(
        right: 15,
        top: 15 + MediaQuery.of(context).padding.top,
        child: const Icon(
          Icons.favorite_outline,
          color: Colors.white,
        ),
      ),
    ],
  );
}

_buildDetails() {
  return const Text(
    '4 guests • 2 bedrooms • 2 beds • 1 bath',
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget _buildFacilitiesTile({required String name, required IconData icon}) {
  return Container(
    margin: const EdgeInsets.only(right: 10),
    alignment: Alignment.center,
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        const SizedBox(height: 10),
        Text(name),
      ],
    ),
  );
}

Map<String, IconData> _facilities = {
  'Wi-Fi': Icons.signal_wifi_4_bar,
  'TV': Icons.tv,
  'Dinner': Icons.local_dining_rounded,
  'Pool': Icons.pool_rounded,
  'Parking': Icons.local_parking,
  "Room Service": Icons.room_service_rounded,
  'Security': Icons.security,
};
