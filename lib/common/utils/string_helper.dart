import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

String timeToGreet(){
  DateTime now = DateTime.now().toLocal();
  if(now.hour>=5&&now.hour<11){
    return 'Selamat Pagi🌄';
  }else if(now.hour>=11&&now.hour<15){
    return 'Selamat Siang☀️';
  }else if(now.hour>=15&&now.hour<19){
    return 'Selamat Sore🌅';
  }else{
    return 'Selamat Malam🌕';
  }
}
String valueRupiah(int value)=>NumberFormat.currency(
    locale: 'id',
    decimalDigits: 0,
    symbol: "Rp ")
    .format(value);
String convertDateTime(DateTime date) {
  final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
  return formatter.format(date);
}
String convertDateDMMmYyyy(DateTime date) {
  final DateFormat formatter = DateFormat('d LLL yyyy');
  return formatter.format(date);
}
String get getToday=>DateFormat('y-MM-dd').format(DateTime.now().toLocal());
String dbDateFormat(DateTime value){
  return DateFormat('y-MM-dd').format(value.toLocal());
}
String valueNoRp(String value){
  String valueNoRp =
  value.replaceAll('Rp ', '');
  String valueFinal =
  valueNoRp.replaceAll('.', '');
  return valueFinal;
}
class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    int value = int.parse(newValue.text);

    String newText =
    NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
        .format(value);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length,));
  }
}
String getDateForLaporan(DateTime date){
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  return formatter.format(date);
}
String getDateDashboard(DateTime date){
  final DateFormat formatter = DateFormat('d LLL y');
  return formatter.format(date);
}