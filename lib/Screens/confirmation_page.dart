import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/Constants/constants.dart';
import 'package:hotel_booking/Controllers/confirmation_controller.dart';
import 'package:hotel_booking/Utils/unfocusser.dart';
import 'package:hotel_booking/Widgets/details_widget.dart';
import 'package:get/get_utils/get_utils.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final control = Get.put(ConfirmationController());
    return GetBuilder<ConfirmationController>(
      builder: (_) {
        return Unfocuser(
          child: Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
              title: Text(
                'Confim Booking',
                style: GoogleFonts.sourceSansPro(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              titleSpacing: 0,
            ),
            body: GetBuilder<ConfirmationController>(
              builder: (_) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildheader(control, context),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: DetailsWidget(
                                title: 'Check-in Date',
                                subtitle:
                                    '${control.checkindate!.day.toString().length == 1 ? '0' '${control.checkindate!.day}' : control.checkindate!.day} ${control.months[control.checkindate!.month - 1]} ${control.checkindate!.year}',
                                control: control,
                                ontap: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: control.checkindate!,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(
                                      const Duration(days: 60),
                                    ),
                                  );

                                  if (selectedDate != null) {
                                    control.checkindate = selectedDate;
                                    if (control.checkindate!
                                        .isAfter(control.checkoutdate!)) {
                                      control.checkoutdate =
                                          control.checkindate!.add(1.days);
                                    }
                                    control.bookingprice();
                                    _.update();
                                  }
                                },
                              ),
                            ),
                            _buildline(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: DetailsWidget(
                                title: 'Check-out Date',
                                subtitle:
                                    '${control.checkoutdate!.day.toString().length == 1 ? '0' '${control.checkoutdate!.day}' : control.checkoutdate!.day} ${control.months[control.checkoutdate!.month - 1]} ${control.checkoutdate!.year}',
                                control: control,
                                ontap: () async {
                                  try {
                                    final selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: control.checkoutdate!,
                                      firstDate:
                                          control.checkindate!.add(1.days),
                                      lastDate: DateTime.now().add(
                                        const Duration(days: 60),
                                      ),
                                    );
                                    if (selectedDate != null) {
                                      control.checkoutdate = selectedDate;
                                      if (control.checkoutdate!
                                          .isBefore(control.checkindate!)) {
                                        control.checkoutdate =
                                            control.checkindate!.add(1.days);
                                      }

                                      control.bookingprice();
                                      _.update();
                                    }
                                  } catch (e) {
                                    Fluttertoast.showToast(msg: e.toString());
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: DetailsWidget(
                                control: control,
                                title: 'Check-in Time',
                                subtitle: (control.checkindate!.hour
                                                .toString()
                                                .length ==
                                            1
                                        ? '0' +
                                            control.checkindate!.hour.toString()
                                        : control.checkindate!.hour
                                            .toString()) +
                                    ' : ' +
                                    (control.checkindate!.minute
                                                .toString()
                                                .length ==
                                            1
                                        ? '0' +
                                            control.checkindate!.minute
                                                .toString()
                                        : control.checkindate!.minute
                                            .toString()),
                                ontap: () async {
                                  final selectedtime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(
                                        control.checkindate!),
                                  );
                                  if (selectedtime != null) {
                                    control.checkindate = DateTime(
                                      control.checkindate!.year,
                                      control.checkindate!.month,
                                      control.checkindate!.day,
                                      selectedtime.hour,
                                      selectedtime.minute,
                                    );
                                    control.checkoutdate = DateTime(
                                      control.checkoutdate!.year,
                                      control.checkoutdate!.month,
                                      control.checkoutdate!.day,
                                      selectedtime.hour,
                                      selectedtime.minute,
                                    );
                                    _.update();
                                  }
                                },
                              ),
                            ),
                            _buildline(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: DetailsWidget(
                                control: control,
                                title: 'Check-out Time',
                                subtitle: (control.checkindate!.hour
                                                .toString()
                                                .length ==
                                            1
                                        ? '0' +
                                            control.checkindate!.hour.toString()
                                        : control.checkindate!.hour
                                            .toString()) +
                                    ' : ' +
                                    (control.checkindate!.minute
                                                .toString()
                                                .length ==
                                            1
                                        ? '0' +
                                            control.checkindate!.minute
                                                .toString()
                                        : control.checkindate!.minute
                                            .toString()),
                                ontap: () async {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: DetailsWidget(
                                title: 'Guests',
                                subtitle: '${control.guests} Guests',
                                control: control,
                                ontap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height: 340,
                                        child: ListView.builder(
                                          itemCount: 6,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                      (index + 1).toString()),
                                                  onTap: () {
                                                    control.guests = index + 1;
                                                    _.update();
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            _buildline(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: DetailsWidget(
                                title: 'Rooms',
                                subtitle: '${control.rooms} Rooms',
                                control: control,
                                ontap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height: 170,
                                        child: ListView.builder(
                                          itemCount: 3,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                      (index + 1).toString()),
                                                  onTap: () {
                                                    control.rooms = index + 1;
                                                    control.bookingprice();
                                                    _.update();
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Address',
                          style: GoogleFonts.sourceSansPro(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () {
                            return Form(
                              key: control.key,
                              autovalidateMode: control.validationmode.value,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: control.address1control,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: 'Address 1',
                                      fillColor: Colors.grey.shade200,
                                      filled: true,
                                    ),
                                    validator: (value) {
                                      return control.checkfileds(value!);
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: control.address2control,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: 'Address 2',
                                      fillColor: Colors.grey.shade200,
                                      filled: true,
                                    ),
                                    validator: (value) {
                                      return control.checkfileds(value!);
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: control.phonecontrol,
                                    keyboardType: TextInputType.phone,
                                    maxLength: 10,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: 'Phone',
                                      fillColor: Colors.grey.shade200,
                                      filled: true,
                                    ),
                                    validator: (value) {
                                      return control.checkphone(value!);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
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
                        text: 'Total amount',
                        style: GoogleFonts.sourceSansPro(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Constants.kprimarycolor,
                          ),
                        ),
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
                        "Pay \$${control.price}",
                        style: GoogleFonts.sourceSansPro(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      onPressed: () {
                        control.openCheckout();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

_buildheader(ConfirmationController control, BuildContext context) {
  return SizedBox(
    height: 150,
    width: MediaQuery.of(context).size.width,
    child: Row(
      children: [
        SizedBox(
          height: 150,
          width: MediaQuery.of(context).size.width * 0.4,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: control.image == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Image.file(control.image!, fit: BoxFit.cover)),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.025),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HOTEL',
              style: GoogleFonts.sourceSansPro(
                textStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              control.data.hotelName,
              style: GoogleFonts.sourceSansPro(
                textStyle: const TextStyle(
                  color: Constants.ksecondarycolor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 9),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: const Text(
                'A hotel is an establishment that provides paid lodging on a short-term basis.Hotel rooms are usually numbered (or named in some smaller hotels and B&Bs) to allow guests to identify their room. Some boutique, high-end hotels have custom decorated rooms. Some hotels offer meals as part of a room and board arrangement.',
                overflow: TextOverflow.ellipsis,
                maxLines: 6,
              ),
            )
          ],
        ),
      ],
    ),
  );
}

_buildline() {
  return Container(
    height: 40,
    width: 1,
    color: Colors.grey,
  );
}
