import 'package:flutter/material.dart';
import 'package:hotel_booking/Constants/constants.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({Key? key, required this.onTap, required this.visible})
      : super(key: key);
  final VoidCallback onTap;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 24,
        width: 24,
        child: Center(
          child: Stack(
            children: [
              const Icon(
                Icons.notifications,
                color: Constants.ksecondarycolor,
                size: 26,
              ),
              Visibility(
                visible: visible,
                child: Positioned(
                  right: 0,
                  top: 2,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        height: 7,
                        width: 7,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
