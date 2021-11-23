import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/presentation/blocs/auth/auth_bloc.dart';
import 'package:kopiek_resto/presentation/views/admin/home.dart';
import 'package:kopiek_resto/presentation/views/home_client.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/views/login_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthBloc _authBloc;
  @override
  void initState() {
    super.initState();
    _authBloc = di<AuthBloc>();
    _authBloc.add(AppStart());
  }

  @override
  void dispose() {
    super.dispose();
    _authBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>_authBloc,
      child: Scaffold(
        body: BlocBuilder<AuthBloc,AuthState>(
          builder: (context,state){
            if(state is AuthLoading){
              return const Center(child: LoadingCircle());
            }else if(state is AuthUnauthenticated){
              return const LoginView();
            }else if(state is AuthAuthenticated){
              if(state.role == 'admin'){
                return const HomeAdmin();
              }else if (state.role == 'pelanggan'){
                return const HomeClient();
              }
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
