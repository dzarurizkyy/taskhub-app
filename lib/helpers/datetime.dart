import 'package:intl/intl.dart';

DateTime combineDateTime(String date, String time) {
  DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(date);
  DateTime parsedTime = DateFormat("hh:mm a").parse(time);

  return DateTime(
    parsedDate.year,
    parsedDate.month,
    parsedDate.day,
    parsedTime.hour,
    parsedTime.minute
  );
}
