import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/presentation/blocs/client/dashboard/dashboard_client_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';

class DashboardClient extends StatefulWidget {
  const DashboardClient({Key? key}) : super(key: key);

  @override
  _DashboardClientState createState() => _DashboardClientState();
}

class _DashboardClientState extends State<DashboardClient> {

  late DashboardClientBloc _dashboardClientBloc;
  @override
  void initState() {
    super.initState();
    _dashboardClientBloc = di<DashboardClientBloc>();
    _dashboardClientBloc.add(FetchDashboardClientEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_)=>_dashboardClientBloc,
        child: BlocBuilder<DashboardClientBloc,DashboardClientState>(
          builder: (context,state){
            if(state is DashboardClientFailure){
              return ErrorPage(label: state.message,onPressed: (){
                _dashboardClientBloc.add(FetchDashboardClientEvent());
              },);
            }else if(state is DashboardClientLoading){
              return const Center(child:LoadingCircle());
            }else if(state is DashboardClientLoaded){
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Selamat Datang,\n${state.user.username}',style: blackTextStyle.copyWith(fontWeight: bold,fontSize: 24),),
                            Badge(
                              position: const BadgePosition(end: -5,top: -5),
                              showBadge: state.notifikasi>0,
                              badgeContent: Text(state.notifikasi.toString(),style: whiteTextStyle,),
                              child: IconButton(onPressed: (){
                                Navigator.pushNamed(context, RouteList.notifkasi);
                              }, icon: const Icon(Icons.notifications)),
                            )
                          ],
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Welcome to Kopiek Resto Apps',style: blackTextStyle.copyWith(fontSize: 16),),
                                vSpace(20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    InkWell(
                                      onTap: (){
                                        Navigator.pushNamed(context, RouteList.order,arguments: 'dine in');
                                      },
                                      child: Column(
                                        children: [
                                          Icon(Icons.restaurant),
                                          vSpace(10),
                                          Text('Dine in')
                                        ],
                                      ),
                                    ),
                                    InkWell(

                                      child: Column(
                                        children: [
                                          Icon(Icons.receipt),
                                          vSpace(10),
                                          Text('Voucher')
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        Navigator.pushNamed(context, RouteList.riwayatPoin);
                                      },
                                      child: Column(
                                        children: [
                                          Icon(Icons.payments),
                                          vSpace(10),
                                          Text('My Point')
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Text('Promo',style: blackTextStyle.copyWith(fontWeight: bold,fontSize: 16),),
                        vSpace(10),
                        ListView.builder(
                          itemCount: state.data.length,
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                            DataVoucher data = state.data[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.network(data.foto),),
                                vSpace(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data.label,style: greyTextStyle,),
                                    Text(valueRupiah(data.diskon),style: blackTextStyle,)
                                  ],
                                ),
                                const Divider(thickness: 1,),
                              ],
                            );
                          },
                        )
                      ],
                    ),
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
