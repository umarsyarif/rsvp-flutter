import 'package:glutton/glutton.dart';

import '../../stores/auth.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  AuthStore _authStore;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> myFuture() async {
    final String token = await Glutton.vomit('token_sanctum');
    if (token != null) {
      return await _authStore
          .getMe()
          .then((value) => true)
          .catchError((error) async {
        await Glutton.digest('token_sanctum');
      });
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    _authStore = Provider.of<AuthStore>(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: bodyFuturePage(),
    ));
  }

  Widget bodyFuturePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FutureBuilder<bool>(
          future: myFuture(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: loadingIndicator(),
              );
            else
              return bodyPageObserver();
          },
        ),
      ],
    );
  }


  Widget loadingIndicator() {
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

  Widget bodyPageObserver() {
    return Observer(builder: (context) => bodyPage());
  }

  Widget bodyPage() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_authStore.user.name),
                SizedBox(height: 20),
                Text(_authStore.user.email),
                SizedBox(height: 20),
                IconButton(
                  icon: Icon(Icons.login),
                  onPressed: () {
                    _authStore.logout().then((value) {
                      Glutton.digest('token_sanctum');
                      Navigator.pushReplacementNamed(context, '/login');
                    });
                  },
                )
              ],
            )
          ],
      ),
    );
  }

  Widget loadingPage() {
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
