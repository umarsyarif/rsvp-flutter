part of 'rating_bloc.dart';

abstract class RatingState extends Equatable {
  const RatingState();
  @override
  List<Object> get props => [];
}

class RatingInitial extends RatingState {

}
class RatingLoading extends RatingState {

}
class RatingLoaded extends RatingState {
  final List<DataRating> data;

  RatingLoaded(this.data);

}
class RatingFailure extends RatingState {
  final String message;

  RatingFailure(this.message);
}
