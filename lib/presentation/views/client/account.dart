import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/presentation/blocs/admin/home/home_admin_bloc.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {

  late HomeAdminBloc _homeAdminBloc;

  @override
  void initState() {
    super.initState();
    _homeAdminBloc = di<HomeAdminBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _homeAdminBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>_homeAdminBloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Account'),
        ),
        body: BlocListener<HomeAdminBloc,HomeAdminState>(
          listener: (context,state){
            if(state is HomeAdminLogout){
              Navigator.pushNamedAndRemoveUntil(context, RouteList.splash, (route) => false);
            }
          },
          child: ErrorPage(
            label: 'Logout',
            onPressed: (){
              _homeAdminBloc.add(LogoutEvent());
            },
          ),
        ),
      ),
    );
  }
}
