import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/data/models/menu_model.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/entities/order_params.dart';
import 'package:kopiek_resto/domain/entities/quantity_order_params.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_menu.dart';

part 'order_detail_event.dart';
part 'order_detail_state.dart';

@injectable
class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final GetMenu getMenu;
  OrderDetailBloc(this.getMenu) : super(OrderDetailInitial()) {
    on<FetchDetailOrderEvent>((event, emit) async {
      emit(OrderDetailLoading());
      final eith = await getMenu.call(NoParams());
      eith.fold(
          (l) => emit(OrderDetailFailure(l.message)),
          (r) {
            List<QuantityOrderParams> quantityMakanan = [];
            List<QuantityOrderParams> quantityMinuman = [];
            quantityMakanan = r.where((element) => element.tipe == 'makanan').map((e) => QuantityOrderParams(e, 0)).toList();
            quantityMinuman = r.where((element) => element.tipe == 'minuman').map((e) => QuantityOrderParams(e, 0)).toList();
            emit(OrderDetailLoaded(
                quantityMakanan,
                quantityMinuman,
                Status.loaded));
          });
    });
  }
}
