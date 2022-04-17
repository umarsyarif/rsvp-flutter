import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';
Future launchUrl(String url)async{
  try{
    await launch(url);
  }catch(e){
    EasyLoading.showError(e.toString());
  }
}