import 'package:intl/intl.dart';

abstract class CalendarUtils {
  static DateTime getFirstSemesterDay() {
    return DateTime.now();
  }

  static DateTime getLastSemesterDay() {
    return DateTime.utc(2024, 6, 30);
  }
}

extension ToBackend on DateTime {
  String toBackendString() {
    return DateFormat('yyyy.MM.dd').format(this);
  }
}

extension FromBackend on String? {
  DateTime toDateTime() {
    return DateFormat('yyyy.MM.dd').parse(this!, true);
  }
}
