import 'package:flutter/material.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';

class ErrorPage extends StatelessWidget {
  final String label;
  final GestureTapCallback onPressed;
  const ErrorPage({Key? key, required this.label, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label,style: blackTextStyle,),
          vSpace(10),
          OutlinedButton(onPressed: onPressed,child: const Text('MUAT ULANG'))
        ],
      ),
    );
  }
}
