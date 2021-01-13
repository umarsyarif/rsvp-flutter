import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './constants/app_theme.dart';
import './routes.dart';
import './stores/auth.store.dart';
import 'helpers/global_scaffold.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthStore>(
          create: (_) => AuthStore(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login App',
        theme: themeData,
        initialRoute: '/loading',
        builder: (context, child) {
          return Scaffold(
            key: GlobalScaffold.instance.scaffkey,
            body: child,
          );
        },
        routes: Routes.routes,
      ),
    );
  }
}
