import 'dart:developer';

import 'package:clean_services_app/server/databases/cached_helper.dart';
import 'package:clean_services_app/utilities/constants.dart';
import 'package:flutter/cupertino.dart';

class Language with ChangeNotifier {
  String localLanguage = 'sv';

  //String? localLanguage = CachedHelper.getLanguage();
  void changeLanguage({fromCached, fromSetting}) {
    if (fromCached != null && fromSetting == null) {
      if (fromCached == notFoundError) {
        localLanguage = 'sv';
        notifyListeners();
      } else {
        localLanguage = fromCached;
        notifyListeners();
      }
    } else if (fromSetting != null && fromCached == null) {
      localLanguage = fromSetting;
      log('selectedLang:$localLanguage');
      CachedHelper.setLanguage(fromSetting);
      notifyListeners();
    } else {
      localLanguage = 'sv';
      notifyListeners();
    }
  }
}
