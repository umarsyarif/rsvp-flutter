import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/login_params.dart';
import 'package:kopiek_resto/domain/usecases/auth/login.dart';
import 'package:kopiek_resto/presentation/blocs/auth/auth_bloc.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login login;
  final LoadingBloc loadingBloc;
  final AuthBloc authBloc;
  LoginBloc(this.login, this.loadingBloc, this.authBloc) : super(LoginInitial()) {
    on<StartLogin>((event, emit) async{
      loadingBloc.add(StartLoading());
      final eith = await login.call(event.params);
      eith.fold((l) => emit(LoginFailure(l.message)), (r) {
        authBloc.add(AppStart());
        final authState = authBloc.state;
        if(authState is AuthAuthenticated){
          emit(LoginSuccess(authState.role));
        }
      });
      loadingBloc.add(FinishLoading());
      emit(LoginInitial());
    });
  }
}
