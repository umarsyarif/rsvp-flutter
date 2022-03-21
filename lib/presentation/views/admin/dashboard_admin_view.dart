import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/data/models/menu_model.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/presentation/blocs/admin/home/home_admin_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/custom_flat_button.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';

class DashboardAdminView extends StatefulWidget {
  final TabController controller;
  const DashboardAdminView({Key? key, required this.controller}) : super(key: key);

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
          actions: [
            IconButton(onPressed: (){
              Navigator.pushNamed(context, RouteList.notifkasi);
            }, icon: const Icon(Icons.notifications))
          ],
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
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          const Divider(thickness:2),
                          Text('MAKANAN',style: blackTextStyle.copyWith(fontWeight: bold,fontSize: 16),),
                          const SizedBox(height: 10,),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.dataMakanan.length>2?2:state.dataMakanan.length,
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.5,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5
                            ),
                            itemBuilder: (context,index){
                              DataMenu menu = state.dataMakanan[index];
                                return MenuCard(menu: menu);
                            },
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: ActionChip(
                              label: Text('Selengkapnya',style: whiteTextStyle.copyWith(fontSize: 10),),
                              backgroundColor: Colors.red,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero
                              ),
                              onPressed: (){
                                Navigator.pushNamed(context, RouteList.dataMaster);
                              },
                            ),
                          ),
                          const Divider(thickness: 2,),
                          Text('MINUMAN',style: blackTextStyle.copyWith(fontWeight: bold,fontSize: 16),),
                          const SizedBox(height: 10,),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.dataMinuman.length>2?2:state.dataMinuman.length,
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.5,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5
                            ),
                            itemBuilder: (context,index){
                              DataMenu menu = state.dataMinuman[index];
                              return MenuCard(menu: menu);
                            },
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: ActionChip(
                              label: Text('Selengkapnya',style: whiteTextStyle.copyWith(fontSize: 10),),
                              backgroundColor: Colors.red,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero
                              ),
                              onPressed: (){
                                Navigator.pushNamed(context, RouteList.dataMaster);
                              },
                            ),
                          ),
                          const SizedBox(height: 50,),
                        ],
                      ),
                    ),
                  ),
                  state.proses+state.paid<1?const SizedBox.shrink():Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      color: AppColor.primary,
                      child: ListTile(
                        onTap: (){
                          widget.controller.index = 1;
                          setState(() {

                          });
                        },
                        leading: const Icon(Icons.shopping_cart,color: Colors.white,),
                        title: Text('${state.proses+state.paid} Pesanan',style:whiteTextStyle),
                        trailing: const Icon(Icons.arrow_forward_ios,color: Colors.white),
                      ),
                    ),
                  )
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({
    Key? key,
    required this.menu,
  }) : super(key: key);

  final DataMenu menu;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(menu.foto),
        Container(
          color: AppColor.primary,
          padding: const EdgeInsets.all(5),
          child: Text('${menu.nama}\n${valueRupiah(menu.harga)}/${menu.satuan.nama}',style: whiteTextStyle.copyWith(fontSize: 10),),
        )
      ],
    );
  }
}
