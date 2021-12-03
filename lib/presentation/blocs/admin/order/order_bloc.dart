import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/order_model.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/usecases/order/get_all_order.dart';
import 'package:kopiek_resto/domain/usecases/order/get_detail_order.dart';

part 'order_event.dart';
part 'order_state.dart';

@injectable
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetAllOrder getAllOrder;
  final GetDetailOrder detailOrder;
  OrderBloc(this.getAllOrder, this.detailOrder) : super(OrderInitial()) {
    on<FetchOrderEvent>((event, emit) async {
      emit(OrderLoading());
      final eith = await getAllOrder.call(NoParams());
      eith.fold((l) => emit(OrderFailure(l.message)), (r) => emit(OrderLoaded(r)));
    });
    on<FetchDetailOrderEvent>((event,emit)async{
      emit(OrderLoading());
      final eith = await detailOrder.call(event.id);
      eith.fold((l) => emit(OrderFailure(l.message)), (r) => emit(OrderDetailLoaded(r)));
    });
  }
}
