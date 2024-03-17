import 'package:intl/intl.dart';

import 'package:movie_colony/core/error/failure.dart';

class Strings {
  static String get theme => 'theme';

  static String get darkTheme => 'DARK_THEME';
  static String get lightTheme => 'LIGHT_THEME';
  static String get apiKeyTmdb => 'api_key_tmdb';
  static String get baseUrl => 'https://api.themoviedb.org/3';
  static String get serverFailureMessage => 'No matches available for this day';
  static String get cacheFailureMessage => 'No internet connection';
  static String get expiry => '_expiry_date';
  static String get notificationList => 'notification-list';

  static String get success => 'success';

  static String get cachedCategory => 'cachedCategory';
  static String get cachedConfiguration => 'cachedConfiguration';
  static String get cachedTrending => 'cacheTrending';
  static String get cachedMovieDetail => 'cachedMovieDetail';

  static String get noImageAvailable =>
      'https://www.esm.rochester.edu/uploads/NoPhotoAvailable.jpg';
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
      return 'Something went wrong, please try again';
    case CacheFailure:
      return 'No internet connection';
    case InvalidFailure:
      return 'Invalid request';
    case ConflictFailure:
      return 'Request failed or not found';

    default:
      return 'Unexpected error';
  }
}
