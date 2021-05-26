import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/cache/app_cache.dart';
import 'package:movie_colony/core/custom_shared_preference/custom_shared_preference.dart';
import 'package:movie_colony/core/utils/strings.dart';

class MockCustomSharedPreference extends Mock
    implements CustomSharedPreference {}

void main() {
  late AppCacheImpl cache;
  late MockCustomSharedPreference mockPref;

  DateTime now = DateTime.now();

  setUp(() {
    mockPref = MockCustomSharedPreference();

    cache = AppCacheImpl(mockPref);
  });
  group('isExpired', () {
    String tExpiryDate1 =
        dateFormat.format(now.subtract(const Duration(seconds: 5)));
    String tExpiryDate2 =
        dateFormat.format(now.add(const Duration(seconds: 5)));

    String tKey = 'key';
    test('return true when current date is after expiry date', () {
      when(mockPref.retrieveData("key_expiry_date")).thenReturn(tExpiryDate1);
      final result = cache.isExpired(tKey);
      verify(mockPref.retrieveData("key_expiry_date"));
      expect(result, true);
    });
    test('return false when current date is before expiry date', () {
      when(mockPref.retrieveData("key_expiry_date")).thenReturn(tExpiryDate2);
      final result = cache.isExpired(tKey);
      verify(mockPref.retrieveData("key_expiry_date"));

      expect(result, false);
    });

    test('return true when expiry date is null', () {
      when(mockPref.retrieveData("key_expiry_date")).thenReturn(null);
      final result = cache.isExpired(tKey);
      verify(mockPref.retrieveData("key_expiry_date"));
      expect(result, true);
    });
  });
}
