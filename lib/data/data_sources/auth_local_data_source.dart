import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/common/extension/preferences_helper.dart';
import 'package:kopiek_resto/data/models/login_model.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';

abstract class AuthLocalDataSource{
  Future<User> getDetailUser();
  Future<bool> checkLogin();
  Future<bool> saveSession(User user,String token);
  Future<bool> logout();
  Future<DataVoucher?> getRedeemedVoucher();
  Future<bool> saveRedeemedVoucher(Map<String,dynamic> body);
}
@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource{
  final String boxName = 'auth';
  @override
  Future<bool> checkLogin() async{
    bool? isLogin = await PreferencesHelper.getValueBool('isLogin');
    return isLogin??false;
  }

  @override
  Future<User> getDetailUser() async{
    final authBox = await Hive.openBox(boxName);
    return User.fromJson(jsonDecode(jsonEncode(await authBox.get('user'))));
  }

  @override
  Future<bool> saveSession(User user,String token) async{
    final authBox = await Hive.openBox(boxName);
    await authBox.put('user', user.toJson());
    await PreferencesHelper.storeValueBool('isLogin', true);
    await PreferencesHelper.storeValueString('token', token);
    return true;
  }

  @override
  Future<bool> logout() async{
    await PreferencesHelper.deleteAll();
    final authBox = await Hive.openBox(boxName);
    await authBox.clear();
    return true;
  }

  @override
  Future<DataVoucher?> getRedeemedVoucher() async {
    final authBox = await Hive.openBox(boxName);
    if(authBox.get('voucher')!=null) {
      return DataVoucher.fromJson(
          jsonDecode(jsonEncode(await authBox.get('voucher'))));
    }else{
      return null;
    }
  }

  @override
  Future<bool> saveRedeemedVoucher(Map<String, dynamic> body) async {
    final authBox = await Hive.openBox(boxName);
    await authBox.put('voucher', body);
    return true;
  }

}