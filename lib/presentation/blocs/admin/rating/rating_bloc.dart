import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/rating_model.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/usecases/order/get_all_rating.dart';

part 'rating_event.dart';
part 'rating_state.dart';

@injectable
class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final GetAllRating getAllRating;
  RatingBloc(this.getAllRating) : super(RatingInitial()) {
    on<FetchRatingEvent>((event, emit) async {
      emit(RatingLoading());
      final eith = await getAllRating.call(NoParams());
      emit(eith.fold((l) => RatingFailure(l.message), (r) => RatingLoaded(r)));
    });
  }
}
