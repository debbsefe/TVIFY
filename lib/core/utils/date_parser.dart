import 'package:intl/intl.dart';

String yearFromDateString(DateTime? date) {
  if (date == null) return '';
  final newFormat = DateFormat('yyyy');
  final String createdAt = newFormat.format(date);
  return createdAt;
}
