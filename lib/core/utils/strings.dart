import '../error/failure.dart';
import 'package:intl/intl.dart';

const String DARK_THEME = "DARK_THEME";
const String LIGHT_THEME = "LIGHT_THEME";
const String API_KEY_TMDB = "api_key_tmdb";
const String BASE_URL = "https://api.themoviedb.org/3";
const String SERVER_FAILURE_MESSAGE = 'No matches available for this day';
const String CACHE_FAILURE_MESSAGE =
    'No internet connection detected or no match found';
const String EXPIRY = "_expiry_date";

const CACHED_CATEGORY = 'CACHED_CATEGORY';
const CACHED_CONFIGURATION = 'CACHED_CATEGORY';

String expiryDate(String key) => key + EXPIRY;

final DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
DateTime now = DateTime.now();

final String sevenDaysLater =
    dateFormat.format(now.add(const Duration(days: 7)));

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
