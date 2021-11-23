import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'loading_event.dart';
part 'loading_state.dart';

@singleton
class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(LoadingInitial()) {
    on<StartLoading>((event, emit) {
      emit(LoadingStarted());
    });
    on<FinishLoading>((event, emit) {
      emit(LoadingFinished());
    });
  }
}
