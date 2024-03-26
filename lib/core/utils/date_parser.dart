import 'package:intl/intl.dart';

String yearFromDateString(String value) {
  final date = DateTime.tryParse(value);

  if (date == null) return '';

  final newFormat = DateFormat('yyyy');
  final String createdAt = newFormat.format(date);
  return createdAt;
}
