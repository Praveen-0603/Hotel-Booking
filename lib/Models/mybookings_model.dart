import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_booking/Models/hotel_model.dart';

class MyBookingModel {
  String? price;
  String? guest;
  String? rooms;
  String? address1;
  String? address2;
  String? phone;
  Timestamp? checkin;
  Timestamp? checkout;
  HotelModel? hotelModel;

  MyBookingModel({
    required this.checkin,
    required this.checkout,
    required this.guest,
    required this.hotelModel,
    required this.price,
    required this.rooms,
    required this.address2,
    required this.address1,
    required this.phone,
  });

  MyBookingModel.fromDocumnetSnapshot(
      DocumentSnapshot<Map<String?, dynamic>> json) {
    price = json.data()!['Price'];
    guest = json.data()!['Guests'];
    address1 = json.data()!['address1'];
    address2 = json.data()!['address2'];
    rooms = json.data()!['Rooms'];
    checkin = json.data()!['Checkin'];
    checkout = json.data()!['Checkout'];
    phone = json.data()!['phone'];
    hotelModel = HotelModel.fromJson(json.data()!['data']);
  }
}
