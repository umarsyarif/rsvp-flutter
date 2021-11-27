import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/register_params.dart';
import 'package:kopiek_resto/domain/usecases/auth/register.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final Register register;
  final LoadingBloc loadingBloc;
  RegisterBloc(this.register, this.loadingBloc) : super(RegisterInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(RegisterLoading());
      loadingBloc.add(StartLoading());
      print(jsonEncode(event.params.toJson()));
      final eith = await register.call(event.params);

      eith.fold((l) => emit(RegisterFailure(l.message)), (r) => emit(RegisterSuccess()));
      loadingBloc.add(FinishLoading());
    });
  }
}
