import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/common/extension/preferences_helper.dart';
import 'package:kopiek_resto/domain/entities/login_params.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/usecases/auth/check_session.dart';
import 'package:kopiek_resto/domain/usecases/auth/get_detail_user.dart';
import 'package:kopiek_resto/domain/usecases/auth/login.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoadingBloc loadingBloc;
  final Login login;
  final CheckSession check;
  final GetDetailUser user;

  AuthBloc(this.loadingBloc, this.login, this.check, this.user) : super(AuthInitial()) {
    on<AppStart>((event,emit)async{
      emit(AuthLoading());
      final cek = await check.call(NoParams());
      late bool isLogin;
      cek.fold((l) => emit(AuthUnauthenticated()), (r){
        isLogin = r;
      });
      if(cek.isRight()){
        if(!isLogin){
          emit(AuthUnauthenticated());
        }
        else{
          final eith = await user.call(NoParams());
          eith.fold((l) => emit(AuthUnauthenticated()),
                  (r) => emit(AuthAuthenticated(r.role)));
        }
      }
    });
    on<StartLogin>((event, emit) async {
      loadingBloc.add(StartLoading());
      final eith = await login.call(LoginParams('ardiprm', 'icefoxpower97'));
      loadingBloc.add(FinishLoading());
      eith.fold((l) => EasyLoading.showError(l.message), (r) => EasyLoading.showSuccess('berhasil'));
    });
  }
}
