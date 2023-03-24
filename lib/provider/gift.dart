import 'dart:developer';

import 'package:clean_services_app/model/gift.dart';
import 'package:clean_services_app/server/databases/gift_helper.dart';
import 'package:clean_services_app/server/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GiftProvider with ChangeNotifier {
  bool isLoading = true;
  List<Gift> _loadedGift = [].cast<Gift>();

  Gift get gift {
    return [..._loadedGift].first;
  }

  void fetchGifts() async {
    globalClient
        .query(QueryOptions(
            document: gql(giftQuery), fetchPolicy: FetchPolicy.noCache))
        .then((result) {
      _loadedGift = GiftHelper.gift(result.data);
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      log(error.toString());
    });
  }
}
