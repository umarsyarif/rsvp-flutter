import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/data/models/login_model.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/entities/pucrhase_order_params.dart';
import 'package:kopiek_resto/domain/usecases/auth/get_detail_user.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_all_voucher.dart';
import 'package:kopiek_resto/domain/usecases/order/post_order.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

@injectable
class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final PostOrder order;
  final GetAllVoucher voucher;
  final LoadingBloc _loadingBloc;
  final GetDetailUser user;
  CheckoutBloc(this.order, this._loadingBloc, this.voucher, this.user) : super(CheckoutInitial()) {
    on<FetchChekcoutEvent>((event,emit)async{
      emit(CheckoutLoading());
      final eithUser = await user.call(NoParams());
      late User userData;
      eithUser.fold((l) => null, (r) => userData=r);
      final eith = await voucher.call('');
      eith.fold((l) => emit(CheckoutFailure(l.message)), (r) => emit(CheckoutLoaded(r, Status.loaded,userData)));
    });
    on<PostCheckout>((event, emit) async{
      final currentState = state;
      if(currentState is CheckoutLoaded){
        _loadingBloc.add(StartLoading());
        final eith = await order.call(event.params);
        eith.fold((l) => emit(currentState.copyWith(errMessage:l.message,status: Status.failure)),
            (r) => emit(currentState.copyWith(status: Status.success,id: r)));
        _loadingBloc.add(FinishLoading());
      }
    });
  }
}
