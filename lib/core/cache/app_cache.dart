import 'package:movie_colony/core/custom_shared_preference/custom_shared_preference.dart';
import 'package:movie_colony/core/utils/strings.dart';

abstract class AppCache {
  final CustomSharedPreference pref;

  AppCache(this.pref);

  ///check if the date is expired by comparing with current date. If current date is after expiry date return true, else return false
  bool isExpired(String key);
}

class AppCacheImpl implements AppCache {
  final CustomSharedPreference pref;

  AppCacheImpl(this.pref);
  @override
  bool isExpired(String key) {
    String? value = pref.retrieveData(expiryDate(key));
    if (value != null) {
      var currentDate = DateTime.now();
      return currentDate.isAfter(DateTime.parse(value));
    } else {
      return true;
    }
  }
}
