import 'package:intl/intl.dart';

class Strings {
  static String toTitleCase(String sentence) {
    String titleCaseVar = sentence
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');

    return titleCaseVar;
  }

  static String getFormattedDate(DateTime dateTime) {
    return new DateFormat("EEEE, MMM d, y").format(dateTime);
  }

  String getDayOfWeek(num? timestamp) {
    if (timestamp == null) return "Unknown";
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp.toInt() * 1000);
    return DateFormat('EEEE').format(date); // Returns: Monday, Tuesday, etc.
  }

}
