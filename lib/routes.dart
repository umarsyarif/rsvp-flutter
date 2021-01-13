import './pages/index/index.dart';
import './pages/loadingPage/loading.dart';
import './pages/login/login.dart';
import './pages/register/register.dart';
import 'package:flutter/material.dart';

// Pages

class Routes {
  static final routes = <String, WidgetBuilder>{
    '/login': (context) => LoginPage(),
    '/register': (context) => RegisterPage(),
    '/index': (context) => IndexPage(),
    '/loading': (context) => LoadingPage(),
  };
}
