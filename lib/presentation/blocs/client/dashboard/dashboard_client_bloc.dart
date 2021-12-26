import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_all_voucher.dart';

part 'dashboard_client_event.dart';
part 'dashboard_client_state.dart';

@injectable
class DashboardClientBloc extends Bloc<DashboardClientEvent, DashboardClientState> {
  final GetAllVoucher voucher;
  DashboardClientBloc(this.voucher) : super(DashboardClientInitial()) {
    on<FetchDashboardClientEvent>((event, emit) async {
      emit(DashboardClientLoading());
      final eith = await voucher.call(NoParams());
      eith.fold((l) => emit(DashboardClientFailure(l.message)), (r) => emit(DashboardClientLoaded(r)));
    });
  }
}
