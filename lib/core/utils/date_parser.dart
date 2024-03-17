import 'package:intl/intl.dart';

String yearFromDateString(String? date) {
  if (date == null) return '';
  final newFormat = DateFormat('yyyy');
  final parseDate = DateTime.parse(date);
  final String createdAt = newFormat.format(parseDate);
  return createdAt;
}
