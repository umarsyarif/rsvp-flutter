import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/usecases/auth/get_redeemed_voucher.dart';
import 'package:kopiek_resto/domain/usecases/auth/save_redeemed_voucher.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_all_voucher.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';

part 'redeem_voucher_event.dart';
part 'redeem_voucher_state.dart';
@injectable
class RedeemVoucherBloc extends Bloc<RedeemVoucherEvent, RedeemVoucherState> {
  final GetAllVoucher voucher;
  final SaveRedeemedVoucher saveRedeemedVoucher;
  final GetRedeemedVoucher getRedeemedVoucher;
  final LoadingBloc loadingBloc;
  RedeemVoucherBloc(this.voucher, this.saveRedeemedVoucher, this.getRedeemedVoucher, this.loadingBloc) : super(RedeemVoucherInitial()) {
    on<FetchRedeemVoucherEvent>((event, emit) async {
      emit(RedeemVoucherLoading());
      final eithRedeem = await getRedeemedVoucher.call(NoParams());
      final eith = await voucher.call('1');
      eith.fold((l) => emit(RedeemVoucherFailure(l.message)), (r) => emit(RedeemVoucherLoaded(Status.loaded, r, eithRedeem.toOption().toNullable())));
    });
    on<SaveRedeemVoucherEvent>((event,emit)async{
      final currentState = state;
      loadingBloc.add(StartLoading());
      if(currentState is RedeemVoucherLoaded){

        emit(currentState.copyWith(status: Status.loading));
        final eith = await saveRedeemedVoucher.call(event.data);
        eith.fold((l) => emit(currentState.copyWith(status: Status.failure)), (r) => emit(currentState.copyWith(status: Status.success,claimed: event.data)));
      }
      loadingBloc.add(FinishLoading());
    });

  }
}
