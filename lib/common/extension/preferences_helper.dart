import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
class PreferencesHelper{
  PreferencesHelper._();
  static late SharedPreferences sharedPreferences;
  static Future storeValueString(String key,String value) async {
    sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  static Future storeValueBool(String key,bool value) async {
    sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setBool(key, value);
  }

  static Future getValue(String key) async {
    sharedPreferences=await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }
  static Future getValueBool(String key) async {
    sharedPreferences=await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }
  static Future deleteValue(String key)async{
    sharedPreferences=await SharedPreferences.getInstance();
    if(sharedPreferences.containsKey(key)){
      sharedPreferences.remove(key);
      log("key deleted",name:"Shared Preference");
    }else{
      log("key not found",name:"Shared Preference");
    }
  }
  static Future deleteAll()async{
    sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}