// To parse this JSON data, do
//
//     final popularHotels = popularHotelsFromJson(jsonString);

import 'dart:convert';

List<HotelModel> getHotelsFromJson(String str) =>
    List<HotelModel>.from(json.decode(str).map((x) => HotelModel.fromJson(x)));

String popularHotelsToJson(List<HotelModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HotelModel {
  HotelModel({
    required this.hotelImage,
    required this.hotelName,
    required this.hotelLocation,
    required this.price,
    required this.rating,
    required this.id,
  });

  String hotelImage;
  String hotelName;
  String hotelLocation;
  String price;
  double rating;
  String id;

  factory HotelModel.fromJson(Map<String, dynamic> json) => HotelModel(
        hotelImage: json["HotelImage"],
        hotelName: json["HotelName"],
        hotelLocation: json["HotelLocation"],
        price: json["Price"],
        rating: json["Rating"].toDouble(),
        id: json["ID"],
      );

  Map<String, dynamic> toJson() => {
        "HotelImage": hotelImage,
        "HotelName": hotelName,
        "HotelLocation": hotelLocation,
        "Price": price,
        "Rating": rating,
        "ID": id,
      };
}
