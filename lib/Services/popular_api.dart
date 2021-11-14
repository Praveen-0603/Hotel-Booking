import 'package:hotel_booking/Models/hotel_model.dart';
import 'package:http/http.dart' as http;

class PopularHotelsRepo {
  static Future<List<HotelModel>> getpopularhotels() async {
    const String url = 'http://617e64fa2ff7e600174bd7aa.mockapi.io/Hotels';

    var response = await http.get(Uri.parse(url));

    List<HotelModel> popularHotels = getHotelsFromJson(response.body);

    return popularHotels;
  }
}
