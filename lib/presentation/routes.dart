import 'package:flutter/material.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/presentation/views/admin/home.dart';
import 'package:kopiek_resto/presentation/views/home_client.dart';
import 'package:kopiek_resto/presentation/views/login_view.dart';

class AppRouter{
  Route? onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteList.login:
        return MaterialPageRoute(builder: (_)=>const LoginView());
      case RouteList.homeAdmin:
        return MaterialPageRoute(builder: (_)=>const HomeAdmin());
      case RouteList.homeClient:
        return MaterialPageRoute(builder: (_)=>const HomeClient());
      default: return null;
    }
  }
}