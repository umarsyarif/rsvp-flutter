import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 200,
      height: 200,
      child:  FlareActor(
        'assets/animation/loading_circle.flr',
        animation: 'load',
        snapToEnd: true,
      ),
    );
  }
}
