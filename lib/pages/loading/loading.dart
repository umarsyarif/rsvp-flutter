import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  
  @override
  Widget build(BuildContext context) {

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
