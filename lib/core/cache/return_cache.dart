abstract class ReturnCache {
  ///check if the date is expired by comparing with current date. If current date is after expiry date return true, else return false
  bool isAfter(DateTime expiryDate);
}

class ReturnCacheImpl implements ReturnCache {
  @override
  bool isAfter(DateTime expiryDate) {
    var currentDate = DateTime.now();
    return currentDate.isAfter(expiryDate);
  }
}
