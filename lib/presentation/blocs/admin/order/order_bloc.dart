import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/data/models/login_model.dart';
import 'package:kopiek_resto/data/models/order_model.dart';
import 'package:kopiek_resto/domain/entities/list_order_params.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/entities/rating_params.dart';
import 'package:kopiek_resto/domain/entities/update_status_params.dart';
import 'package:kopiek_resto/domain/usecases/auth/get_detail_user.dart';
import 'package:kopiek_resto/domain/usecases/order/check_rating.dart';
import 'package:kopiek_resto/domain/usecases/order/get_all_order.dart';
import 'package:kopiek_resto/domain/usecases/order/get_detail_order.dart';
import 'package:kopiek_resto/domain/usecases/order/post_rating.dart';
import 'package:kopiek_resto/domain/usecases/order/update_status.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';

part 'order_event.dart';

part 'order_state.dart';

@injectable
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetAllOrder getAllOrder;
  final GetDetailUser user;
  final GetDetailOrder detailOrder;
  final LoadingBloc _loadingBloc;
  final UpdateStatus updateStatus;
  final CheckRating checkRating;
  final PostRating postRating;

  OrderBloc(this.getAllOrder, this.detailOrder, this.user, this.updateStatus,
      this._loadingBloc, this.checkRating, this.postRating)
      : super(OrderInitial()) {
    on<FetchOrderEvent>((event, emit) async {
      emit(OrderLoading());
      final eithUser = await user.call(NoParams());
      late User userData;
      eithUser.fold((l) => null, (r) {
        userData = r;
      });
      bool isReview = false;
      if (userData.role != 'admin' && event.status == 'selesai') {
        final eithCheck = await checkRating.call(userData.id);
        isReview = eithCheck.fold((l) => false, (r) => r);
      }
      final eith = await getAllOrder.call(ListOrderParams(event.status,
          idPengguna: userData.role == 'admin' ? null : userData.id.toString(),
          start: event.start,
          end: event.end));
      eith.fold(
          (l) => emit(OrderFailure(l.message)),
          (r) => emit(OrderLoaded(r, event.start, event.end,
              isReview: isReview && r.isNotEmpty,idUser: userData.id.toString())));
    });
    on<FetchDetailOrderEvent>((event, emit) async {
      emit(OrderLoading());
      final eithUser = await user.call(NoParams());
      late User userData;
      eithUser.fold((l) => null, (r) {
        userData = r;
      });
      final eith = await detailOrder.call(event.id);
      eith.fold((l) => emit(OrderFailure(l.message)),
          (r) => emit(OrderDetailLoaded(r, Status.loaded, userData)));
    });
    on<UpdateStatusOrderEvent>((event, emit) async {
      _loadingBloc.add(StartLoading());
      final currentState = state;
      if (currentState is OrderDetailLoaded) {
        final eith = await updateStatus.call(event.params);
        eith.fold(
            (l) => emit(currentState.copyWith(
                status: Status.failure, errMessage: l.message)),
            (r) => emit(currentState.copyWith(status: Status.success)));
      }
      _loadingBloc.add(FinishLoading());
    });
    on<PostRatingEvent>((event, emit) async {
      final currentState = state;
      if (currentState is OrderLoaded) {
        _loadingBloc.add(StartLoading());
        final eithRating = await postRating.call(event.params);
        eithRating.fold((l) => emit(currentState.copyWith(errMessage: l.message,
            status: Status.failure)), (r) => emit(currentState.copyWith
          (status: Status.success)));
        _loadingBloc.add(FinishLoading());
      }
    });
  }
}
