import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/login_model.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/usecases/auth/get_detail_user.dart';
import 'package:kopiek_resto/domain/usecases/auth/logout.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

@injectable
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetDetailUser user;
  final Logout logout;
  final LoadingBloc loadingBloc;
  AccountBloc(this.user, this.logout, this.loadingBloc) : super(AccountInitial()) {
    on<FetchAccountEvent>((event, emit) async{
      emit(AccountLoading());
      final eith = await user.call(NoParams());
      eith.fold((l) => emit(AccountFailure()), (r) => emit(AccountLoaded(r)));
    });
    on<LogoutAccountEvent>((event,emit)async{
      loadingBloc.add(StartLoading());
      final eith = await logout.call(NoParams());
      eith.fold((l) => emit(AccountLogout()), (r) => emit(AccountLogout()));
      loadingBloc.add(FinishLoading());
    });
  }
}
