part of 'rating_bloc.dart';

abstract class RatingEvent extends Equatable {
  const RatingEvent();
  @override
  List<Object> get props => [];
}
class FetchRatingEvent extends RatingEvent{}
