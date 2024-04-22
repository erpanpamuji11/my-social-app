import 'package:intl/intl.dart';

class DatesUtils {
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(DateTime.parse('$date'));
  }

  static String formatDate2(String date) {
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(date);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }
}
