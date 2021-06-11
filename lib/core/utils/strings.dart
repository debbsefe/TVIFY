import 'package:intl/intl.dart';

import '../error/failure.dart';

class Strings {
  static String get theme => 'theme';

  static String get darkTheme => 'DARK_THEME';
  static String get lightTheme => 'LIGHT_THEME';
  static String get apiKeyTmdb => 'api_key_tmdb';
  static String get baseUrl => 'https://api.themoviedb.org/3';
  static String get serverFailureMessage => 'No matches available for this day';
  static String get cacheFailureMessage =>
      'No internet connection detected or no match found';
  static String get expiry => '_expiry_date';

  static String get cachedCategory => 'cachedCategory';
  static String get cachedConfiguration => 'cachedConfiguration';
  static String get cachedTrending => 'cacheTrending';

  static String get firstTimeUser => 'firstTimeUser';
}

String expiryDate(String key) => key + Strings.expiry;

final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
DateTime now = DateTime.now();

final String sevenDaysLater =
    dateFormat.format(now.add(const Duration(days: 7)));

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return Strings.serverFailureMessage;
    case CacheFailure:
      return Strings.cacheFailureMessage;
    default:
      return 'Unexpected error';
  }
}
