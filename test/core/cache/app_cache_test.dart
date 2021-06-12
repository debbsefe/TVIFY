import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/cache/app_cache.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late AppCacheImpl cache;
  late MockSharedPreferences mockPref;

  DateTime now = DateTime.now();
  const String tKey = 'tKey';
  const String tString = 'tValue';
  const bool tBool = true;

  setUp(() {
    mockPref = MockSharedPreferences();

    cache = AppCacheImpl(mockPref);
  });
  group('isExpired', () {
    String tExpiryDate1 =
        dateFormat.format(now.subtract(const Duration(seconds: 5)));
    String tExpiryDate2 =
        dateFormat.format(now.add(const Duration(seconds: 5)));

    String tKey = 'key';
    test('return true when current date is after expiry date', () {
      when(cache.retrieveString('key_expiry_date')).thenReturn(tExpiryDate1);
      final result = cache.isExpired(tKey);
      verify(cache.retrieveString('key_expiry_date'));
      expect(result, true);
    });
    test('return false when current date is before expiry date', () {
      when(cache.retrieveString('key_expiry_date')).thenReturn(tExpiryDate2);
      final result = cache.isExpired(tKey);
      verify(cache.retrieveString('key_expiry_date'));

      expect(result, false);
    });

    test('return true when expiry date is null', () {
      when(cache.retrieveString('key_expiry_date')).thenReturn(null);
      final result = cache.isExpired(tKey);
      verify(cache.retrieveString('key_expiry_date'));
      expect(result, true);
    });
  });

  group('Save String', () {
    test('should save string when saveString called', () {
      cache.saveString(tKey, tString);

      verify(mockPref.setString(tKey, tString));
    });
  });
  group('Retrieve String', () {
    test('should return string when retrieveString is called', () {
      when(cache.retrieveString(tKey)).thenReturn(tString);

      expect(cache.retrieveString(tKey), tString);
    });

    test('should return null when no string is saved', () {
      when(cache.retrieveString(tKey)).thenReturn(null);
      expect(cache.retrieveString(tKey), null);
    });
  });

  group('Save Bool', () {
    test('should save bool when saveBool called', () {
      cache.saveBool(tKey, tBool);

      verify(mockPref.setBool(tKey, tBool));
    });
  });
  group('Retrieve Bool', () {
    test('should return bool when retrieveBool is called', () {
      when(cache.retrieveBool(tKey)).thenReturn(tBool);

      expect(cache.retrieveBool(tKey), tBool);
    });

    test('should return null when no boolean is saved', () {
      when(cache.retrieveBool(tKey)).thenReturn(null);
      expect(cache.retrieveBool(tKey), null);
    });
  });
}
