import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/cache/return_cache.dart';

void main() {
  late ReturnCacheImpl cache;
  DateTime now = DateTime.now();

  setUp(() {
    cache = ReturnCacheImpl();
  });
  group('isAfter', () {
    test('return true when current date is before expiry date', () {
      DateTime expiryDate = now.subtract(const Duration(seconds: 5));

      final result = cache.isAfter(expiryDate);
      expect(result, true);
    });
    test('return false when current date is after expiry date', () {
      DateTime expiryDate = now.add(const Duration(seconds: 5));
      final result = cache.isAfter(expiryDate);
      expect(result, false);
    });
  });
}
