import 'package:intl/intl.dart';

class DateUtil {
  DateTime _datanow = new DateTime.now();
  DateTime _datahora;

  String formatDataDay() {
    return DateFormat('dd/MM/yyyy').format(this._datanow);
  }

  String formatDataDayHour() {
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(this._datahora);
  }

//
//  String formatTimestamp (int timestamp) {
//    var format = new DateFormat ('dd/MM/yyyy');
//    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
//    return format.format(date);
//  }
//
//  DateTime convertTimeStampToDateTime(int timeStamp) {
//    var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
//    return dateToTimeStamp;
//  }
//  String formatData(DateTime data) {return DateFormat('dd/MM/yyyy').format(data);}
//
//  DateTime parseData(String data) {return DateTime.parse(data);}
}
