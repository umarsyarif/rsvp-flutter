import 'package:flutter/material.dart';


import './pages/loading/loading.dart';

// Pages

class Routes {
   static final routes = <String, WidgetBuilder>{
     '/loading': (context) => LoadingPage(),
  };
}
