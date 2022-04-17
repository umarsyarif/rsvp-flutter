import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/presentation/blocs/admin/konfigurasi/konfigurasi_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';

class KonfigurasiView extends StatefulWidget {
  const KonfigurasiView({Key? key}) : super(key: key);

  @override
  _KonfigurasiViewState createState() => _KonfigurasiViewState();
}

class _KonfigurasiViewState extends State<KonfigurasiView> {
  late KonfigurasiBloc _konfigurasiBloc;

  @override
  void initState() {
    super.initState();
    _konfigurasiBloc = di<KonfigurasiBloc>();
    _konfigurasiBloc.add(FetchKonfigurasiEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _konfigurasiBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>_konfigurasiBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pengaturan'),
        ),
        body: BlocConsumer<KonfigurasiBloc,KonfigurasiState>(
          listener:(context,state){
            if(state is KonfigurasiLogout){
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteList.login, (route) => false);
            }
          },
          builder:(context,state){
            if(state is KonfigurasiLoading){
              return const Center(child:LoadingCircle());
            }else if(state is KonfigurasiFailure){
              return ErrorPage(label: state.message,onPressed: (){
                _konfigurasiBloc.add(FetchKonfigurasiEvent());
              },);
            }else if(state is KonfigurasiLoaded){

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(child: Icon(Icons.schedule,color: Colors.white,),backgroundColor: AppColor.primary,),
                        title: Text('Jadwal Restoran'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: (){
                          Navigator.pushNamed(context, RouteList.jadwalRestoran);
                        },

                      ),
                      ListTile(
                        leading: CircleAvatar(child: Icon(Icons.settings,color: Colors.white,),backgroundColor: AppColor.primary,),
                        title: Text('Data Master'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: (){
                          Navigator.pushNamed(context, RouteList.dataMaster);
                        },
                      ),
                      ListTile(
                        leading: CircleAvatar(child: Icon(Icons.settings,color: Colors.white,),backgroundColor: AppColor.primary,),
                        title: Text('Profil Restoran'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: (){
                          Navigator.pushNamed(context, RouteList.ubahProfilResto);
                        },
                      ),
                      ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.logout,color: Colors.white,),backgroundColor: AppColor.primary,),
                        title: Text('Logout',style: blackTextStyle.copyWith(fontWeight: bold),),
                        onTap: (){
                          _konfigurasiBloc.add(LogoutEvent());
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
