import 'package:intl/intl.dart';

DateTime combineDateTime(String date, String time) {
  DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(date);
  DateTime parsedTime = DateFormat("hh:mm").parse(time);

  return DateTime(parsedDate.year, parsedDate.month, parsedDate.day,
      parsedTime.hour, parsedTime.minute);
}

String getTimePeriod(DateTime date) {
  int hour = date.hour;

  if (hour >= 5 && hour < 12) {
    return "Morning";
  } else if (hour >= 12 && hour < 15) {
    return "Afternoon";
  } else if (hour >= 15 && hour < 18) {
    return "Evening";
  } else {
    return "Night";
  }
}
