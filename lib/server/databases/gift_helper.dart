
import 'package:clean_services_app/model/gift.dart';

class GiftHelper {
  static List<Gift> loadedGift = [].cast<Gift>();
  bool isLoading = true;


  static List<Gift> gift(Map<String, dynamic>? data) {
    final gifts = data!["me"]["allGifts"][0];
    if (gifts['gift_status']['status_code'] == 100) {
      loadedGift.add(Gift(
          id: gifts['id'],
          name: gifts['name'],
          discount: gifts['discount'],
          statusCode: gifts['gift_status']['status_code'],
          status: gifts['gift_status']['status']));
    }
    //  fetchedOrders = orders.where((order) => order.statusCode != 100).toList();
    return loadedGift;
  }

  Gift get getGiftData {
    return [...loadedGift].first;
  }
}
