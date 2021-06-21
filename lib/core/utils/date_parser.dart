import 'package:intl/intl.dart';

String yearFromDateString(String? date) {
  if (date == null) return '';
  var newFormat = DateFormat('yyyy');
  var parseDate = DateTime.parse(date);
  String createdAt = newFormat.format(parseDate);
  return createdAt;
}
