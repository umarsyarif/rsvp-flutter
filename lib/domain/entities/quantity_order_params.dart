import 'package:kopiek_resto/data/models/menu_model.dart';

class QuantityOrderParams{
  final DataMenu menu;
  int jumlah;
  String catatan;
  QuantityOrderParams(this.menu,this.jumlah,{this.catatan=''});
}