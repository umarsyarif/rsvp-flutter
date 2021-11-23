part of 'loading_bloc.dart';

@immutable
abstract class LoadingEvent extends Equatable {
  const LoadingEvent();
  @override
  List<Object?> get props => [];
}

class StartLoading extends LoadingEvent {}

class FinishLoading extends LoadingEvent {}

