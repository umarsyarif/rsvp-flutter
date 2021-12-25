import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/data/core/api_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPaymentView extends StatefulWidget {
  final String id;
  const WebPaymentView({Key? key, required this.id}) : super(key: key);

  @override
  _WebPaymentViewState createState() => _WebPaymentViewState();
}

class _WebPaymentViewState extends State<WebPaymentView> {

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    print('${ApiConstants.baseUrl}/payment?id=${widget.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selesaikan Pembayaran'),
      ),
      body: WebView(
        initialUrl: '${ApiConstants.baseUrl}/payment?id=${widget.id}',
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: <JavascriptChannel>{
          JavascriptChannel(
            name: 'Print',
            onMessageReceived: (JavascriptMessage receiver) {
              print('==========>>>>>>>>>>>>>> BEGIN');
              print(receiver.message);
              if (receiver.message != null || receiver.message != 'undefined') {
                if (receiver.message == 'close') {
                  Navigator.pop(context);
                } else {

                }
              }
              print('==========>>>>>>>>>>>>>> END');
            },
          ),
          JavascriptChannel(
            name: 'Android',
            onMessageReceived: (JavascriptMessage receiver) {
              print('==========>>>>>>>>>>>>>> BEGIN');
              print(receiver.message);
              if (Platform.isAndroid) {
                if (receiver.message != null || receiver.message != 'undefined') {
                  if (receiver.message == 'close') {
                    Navigator.pushNamedAndRemoveUntil(context, RouteList.homeClient, (route) => false);
                  } else {

                  }
                }
              }
              print('==========>>>>>>>>>>>>>> END');
            },
          ),
        },
      ),
    );
  }
}
