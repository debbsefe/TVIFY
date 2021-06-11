import '../custom_shared_preference/custom_shared_preference.dart';
import '../utils/strings.dart';

abstract class AppCache {
  AppCache(this.pref);

  final CustomSharedPreference pref;

  ///check if the date is expired by comparing with current date.
  ///If current date is after expiry date return true, else return false
  bool isExpired(String key);
}

class AppCacheImpl implements AppCache {
  AppCacheImpl(this.pref);

  final CustomSharedPreference pref;

  @override
  bool isExpired(String key) {
    String? value = pref.retrieveString(expiryDate(key));
    if (value != null) {
      var currentDate = DateTime.now();
      return currentDate.isAfter(DateTime.parse(value));
    } else {
      return true;
    }
  }
}
