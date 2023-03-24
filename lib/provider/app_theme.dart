import 'package:clean_services_app/server/databases/cached_helper.dart';
import 'package:clean_services_app/utilities/constants.dart';
import 'package:flutter/cupertino.dart';

class AppTheme extends ChangeNotifier{

  bool isDark = false;

  void themeToggle({fromCached}){
    if(fromCached != null){
      if(fromCached == notFoundError){
        isDark = false;
        notifyListeners();
      }else{
        isDark = fromCached;
        notifyListeners();
      }
    }else{
      isDark = !isDark;
      CachedHelper.setThemeMode(isDark);
      notifyListeners();
    }

  }
}