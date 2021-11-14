import 'package:get/get_utils/get_utils.dart';

class OffersRepo {
  Future<List<String>> getoffers() async {
    return await getoffersurl();
  }
}

Future<List<String>> getoffersurl() {
  final ft = Future.delayed(2.seconds, () {
    return data;
  });
  return ft;
}

List<String> data = [
  'https://images.via.com/static/dynimg/search_page/40/normal/1016988951-1016988950_up-to-70-off-on-all-hotels-offer-994-x-415-1jpg.jpg',
  'https://gos3.ibcdn.com/top-1544707638.jpg',
  'https://gos3.ibcdn.com/top-1549373929.jpg',
];
