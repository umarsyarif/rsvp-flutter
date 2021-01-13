import 'package:flutter/material.dart';

import 'package:glutton/glutton.dart';


import '../../stores/auth.store.dart';

import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  AuthStore _authStore;


  @override
  void initState() {
    super.initState();
    _checkAuth().then(
      (value) {
        if (value) {
          Navigator.pushReplacementNamed(context, '/index');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
    );
  }

  Future<bool> _checkAuth() async {
    final String token = await Glutton.vomit('token_sanctum');
    if (token != null) {
      return await _authStore
          .getMe()
          .then((value) => true)
          .catchError((error) async {
        await Glutton.digest('token_sanctum').then((value) => true);
      });
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    _authStore = Provider.of<AuthStore>(context);

    return Scaffold(
      body: bodyPage(),
    );
  }

  Widget bodyPage() {
    return Container(
      color: Colors.grey.withOpacity(0.5),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
