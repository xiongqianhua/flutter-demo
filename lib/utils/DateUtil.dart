import 'package:flustars/flustars.dart';
import 'package:intl/intl.dart';

class SdopDateUtils {
  static const String DATE_TIME_PATTERN = "yyyy-MM-dd HH:mm:ss";
  static const String MINUTE_PATTERN = "yyyy-MM-dd HH:mm";
  static const String HOUR_PATTERN = "yyyy-MM-dd HH:mm:ss";
  static const String DATE_PATTERN = "yyyy-MM-dd";
  static const String DAY_PATTERN = "MM-dd";
  static const String MONTH_PATTERN = "yyyy-MM";
  static const String YEAR_PATTERN = "yyyy";
  static const String MINUTE_ONLY_PATTERN = "mm";
  static const String HOUR_ONLY_PATTERN = "HH";

  String strDateToString(String strDate, {String pattern = DATE_TIME_PATTERN}) {
    var date = DateTime.parse(strDate).toLocal();
    var format = new DateFormat(pattern);
    String formatted = format.format(date);
    return formatted;
  }

  String tsToDate(int ts, {String pattern = DATE_TIME_PATTERN}) {
    var date = DateTime.fromMicrosecondsSinceEpoch(ts).toLocal();
    var format = new DateFormat(pattern);
    String formatted = format.format(date);
    return formatted;
  }

  static int nowTimestamp() {
    return DateTime.now().microsecondsSinceEpoch ~/ 1000000;
  }
}
