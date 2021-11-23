
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';

class LoadingScreen extends StatelessWidget {
  final Widget screen;

  const LoadingScreen({Key? key, required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingBloc, LoadingState>(
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            screen,
            if (state is LoadingStarted)
              Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
                child: const Center(
                  child: LoadingCircle(),
                ),
              ),
          ],
        );
      },
    );
  }
}
