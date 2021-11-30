import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/pucrhase_order_params.dart';
import 'package:kopiek_resto/domain/usecases/order/post_order.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

@injectable
class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final PostOrder order;
  final LoadingBloc _loadingBloc;
  CheckoutBloc(this.order, this._loadingBloc) : super(CheckoutInitial()) {
    on<PostCheckout>((event, emit) async{
      _loadingBloc.add(StartLoading());
      emit(CheckoutLoading());
      final eith = await order.call(event.params);
      eith.fold((l) => emit(CheckoutFailure(l.message)), (r) => emit(CheckoutSuccess()));
      _loadingBloc.add(FinishLoading());
    });
  }
}
