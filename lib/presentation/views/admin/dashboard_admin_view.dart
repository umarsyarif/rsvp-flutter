import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/presentation/blocs/admin/home/home_admin_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';

class DashboardAdminView extends StatefulWidget {
  const DashboardAdminView({Key? key}) : super(key: key);

  @override
  _DashboardAdminViewState createState() => _DashboardAdminViewState();
}

class _DashboardAdminViewState extends State<DashboardAdminView> {

  late HomeAdminBloc _homeAdminBloc;

  @override
  void initState() {
    super.initState();
    _homeAdminBloc = di<HomeAdminBloc>();
    _homeAdminBloc.add(FetchHomeAdmin());
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
        appBar: AppBar(title: const Text('Dashboard'),
        ),
        body: BlocBuilder<HomeAdminBloc,HomeAdminState>(
          builder: (context,state){
            if(state is HomeAdminFailure){
              return ErrorPage(label: state.message, onPressed: (){
                _homeAdminBloc.add(FetchHomeAdmin());
              });
            }else if(state is HomeAdminLoading){
              return const Center(child: LoadingCircle(),);
            }else if(state is HomeAdminLoaded){
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: AppColor.primary,
                          child: Icon(Icons.sync,color: Colors.white,),
                        ),
                        trailing: Text(state.proses.toString()),
                        title: const Text('Diproses'),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: AppColor.primary,
                          child: Icon(Icons.payments,color: Colors.white,),
                        ),
                        trailing: Text(state.paid.toString()),
                        title: const Text('Sudah Bayar'),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: AppColor.primary,
                          child: Icon(Icons.done,color: Colors.white,),
                        ),
                        trailing: Text(state.selesai.toString()),
                        title: const Text('Selesai'),
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
