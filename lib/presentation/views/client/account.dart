import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/presentation/blocs/admin/home/home_admin_bloc.dart';
import 'package:kopiek_resto/presentation/blocs/client/account/account_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {

  late AccountBloc _accountBloc;

  @override
  void initState() {
    super.initState();
    _accountBloc = di<AccountBloc>();
    _accountBloc.add(FetchAccountEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _accountBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>_accountBloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('Account'),
        ),
        body: BlocConsumer<AccountBloc,AccountState>(
          listener: (context,state){
            if(state is AccountLogout){
              Navigator.pushNamedAndRemoveUntil(context, RouteList.splash, (route) => false);
            }
          },
          builder: (context,state){
            if(state is AccountFailure){
              return ErrorPage(
                label: 'Gagal memuat',
                onPressed: (){
                  _accountBloc.add(FetchAccountEvent());
                },
              );
            }else if(state is AccountLoading){
              return const Center(child: LoadingCircle(),);
            }else if(state is AccountLoaded){

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListTile(
                          leading: const CircleAvatar(child: Icon(Icons.person,color: Colors.white,),backgroundColor: AppColor.primary,),
                          title: Text('Username',style: blackTextStyle.copyWith(fontWeight: bold),),
                          subtitle: Text(state.user.username,style: greyTextStyle,),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListTile(
                          leading: const CircleAvatar(child: Icon(Icons.email,color: Colors.white,),backgroundColor: AppColor.primary,),
                          title: Text('Email',style: blackTextStyle.copyWith(fontWeight: bold),),
                          subtitle: Text(state.user.email,style: greyTextStyle,),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListTile(
                          leading: const CircleAvatar(child: Icon(Icons.home,color: Colors.white,),backgroundColor: AppColor.primary,),
                          title: Text('Alamat',style: blackTextStyle.copyWith(fontWeight: bold),),
                          subtitle: Text(state.user.alamat,style: greyTextStyle,),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListTile(
                          leading: const CircleAvatar(child: Icon(Icons.phone,color: Colors.white,),backgroundColor: AppColor.primary,),
                          title: Text('No HP',style: blackTextStyle.copyWith(fontWeight: bold),),
                          subtitle: Text(state.user.noHp,style: greyTextStyle,),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListTile(
                          leading: const CircleAvatar(child: Icon(Icons.restaurant,color: Colors.white,),backgroundColor: AppColor.primary,),
                          title: Text('Tentang restoran',style: blackTextStyle.copyWith(fontWeight: bold),),
                          onTap: (){
                            Navigator.pushNamed(context, RouteList.lihatProfilResto);
                          },
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListTile(
                          leading: const CircleAvatar(child: Icon(Icons.logout,color: Colors.white,),backgroundColor: AppColor.primary,),
                          title: Text('Logout',style: blackTextStyle.copyWith(fontWeight: bold),),
                          onTap: (){
                            _accountBloc.add(LogoutAccountEvent());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          }
        ),
      ),
    );
  }
}
