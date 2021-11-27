import 'package:flutter/material.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/presentation/views/admin/home.dart';
import 'package:kopiek_resto/presentation/views/client/order/order_view.dart';
import 'package:kopiek_resto/presentation/views/home_client.dart';
import 'package:kopiek_resto/presentation/views/login_view.dart';
import 'package:kopiek_resto/presentation/views/register.dart';
import 'package:kopiek_resto/presentation/views/splash_screen.dart';

class AppRouter{
  Route? onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteList.splash:
        return MaterialPageRoute(builder: (_)=>const SplashScreen());
      case RouteList.login:
        return MaterialPageRoute(builder: (_)=>const LoginView());
      case RouteList.homeAdmin:
        return MaterialPageRoute(builder: (_)=>const HomeAdmin());
      case RouteList.homeClient:
        return MaterialPageRoute(builder: (_)=>const HomeClient());
      case RouteList.register:
        return MaterialPageRoute(builder: (_)=>const RegisterView());
      case RouteList.order:
        return MaterialPageRoute(builder: (_)=> OrderView(jenis: settings.arguments.toString(),));
      default: return null;
    }
  }
}