import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/usecases/auth/logout.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';

part 'home_admin_event.dart';
part 'home_admin_state.dart';

@injectable
class HomeAdminBloc extends Bloc<HomeAdminEvent, HomeAdminState> {
  final Logout logout;
  final LoadingBloc loadingBloc;
  HomeAdminBloc(this.logout, this.loadingBloc) : super(HomeAdminInitial()) {
    on<LogoutEvent>((event, emit) async{
      loadingBloc.add(StartLoading());
      final eith = await logout.call(NoParams());
      eith.fold((l) => null, (r) => emit(HomeAdminLogout()));
      loadingBloc.add(FinishLoading());
    });
  }
}
