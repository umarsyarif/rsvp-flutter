import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/data/models/menu_model.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/domain/entities/order_params.dart';
import 'package:kopiek_resto/presentation/blocs/client/order-detail/order_detail_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/custom_flat_button.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';

class DetailOrderView extends StatefulWidget {
  final OrderParams params;
  const DetailOrderView({Key? key, required this.params}) : super(key: key);

  @override
  _DetailOrderViewState createState() => _DetailOrderViewState();
}

class _DetailOrderViewState extends State<DetailOrderView> with SingleTickerProviderStateMixin{

  late OrderDetailBloc _detailBloc;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _detailBloc = di<OrderDetailBloc>();
    _detailBloc.add(FetchDetailOrderEvent());
    _tabController = TabController(length: 2, vsync: this,initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _detailBloc.close();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>_detailBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail Order'),
        ),
        body: BlocBuilder<OrderDetailBloc,OrderDetailState>(
          builder: (context,state){
            if(state is OrderDetailLoading){
              return const Center(child: LoadingCircle(),);
            }else if(state is OrderDetailFailure){
              return ErrorPage(label: state.message, onPressed: (){
                _detailBloc.add(FetchDetailOrderEvent());
              });
            }else if(state is OrderDetailLoaded){
              return Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Customer',style:  blackTextStyle,),
                                Text(getDateDashboard(DateTime.parse(widget.params.tanggal)),style:  blackTextStyle,)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.params.jenis,style:  blackTextStyle,),
                                Text(widget.params.jam,style:  blackTextStyle,),
                              ],
                            ),
                            const Divider(thickness: 1,),
                            Text('MAKANAN',style: blackTextStyle.copyWith(fontSize: 16,fontWeight: bold),),
                            vSpace(20),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.makanan.length,
                              itemBuilder: (context,index){
                                DataMenu data = state.makanan[index].menu;
                                return Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child: Image.network(data.foto,height: 75,),flex: 4,),
                                          Spacer(),
                                          Expanded(child: Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: [
                                              Text(data.nama),
                                              Text(valueRupiah(data.harga)),
                                            ],
                                          ),flex: 8,),

                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                IconButton(icon: Icon(Icons.add_circle_outline),onPressed: (){
                                                  state.makanan[index].jumlah+=1;
                                                  setState(() {

                                                  });
                                                },),
                                                Text(state.makanan[index].jumlah.toString()),
                                                IconButton(icon: Icon(Icons.remove_circle_outline),onPressed: (){
                                                  if(state.makanan[index].jumlah > 0){
                                                      state.makanan[index].jumlah -= 1;
                                                      setState(() {});
                                                    }
                                                  },),
                                              ],
                                            ),
                                            flex: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                  ],
                                );
                              },
                            ),
                            Text('MINUMAN',style: blackTextStyle.copyWith(fontSize: 16,fontWeight: bold),),
                            vSpace(20),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.minuman.length,
                              itemBuilder: (context,index){
                                DataMenu data = state.minuman[index].menu;
                                return Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child: Image.network(data.foto,height: 75,),flex: 4,),
                                          Spacer(),
                                          Expanded(child: Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: [
                                              Text(data.nama),
                                              Text(valueRupiah(data.harga)),
                                            ],
                                          ),flex: 8,),

                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                IconButton(icon: Icon(Icons.add_circle_outline),onPressed: (){
                                                  state.minuman[index].jumlah+=1;
                                                  setState(() {

                                                  });
                                                },),
                                                Text(state.minuman[index].jumlah.toString()),
                                                IconButton(icon: Icon(Icons.remove_circle_outline),onPressed: (){
                                                  if(state.minuman[index].jumlah>0){
                                                      state.minuman[index].jumlah -= 1;
                                                    }
                                                    setState(() {

                                                  });
                                                },),
                                              ],
                                            ),
                                            flex: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider()
                                  ],
                                );
                              },
                            ),
                            vSpace(20),
                            CustomFlatButton(backgroundColor: AppColor.primary, label: 'SIMPAN', onPressed: (){
                              if(state.makanan.where((element) => element.jumlah>0).length+state.minuman.where((element) => element.jumlah>0).length<1){
                                EasyLoading.showError('Silahkan pilih menu terebih dahulu');
                              }else{
                                Navigator.pushNamed(context, RouteList.checkout,arguments: {
                                  'makanan':state.makanan.where((element) => element.jumlah>0).toList(),
                                  'minuman':state.minuman.where((element) => element.jumlah>0).toList(),
                                  'order':widget.params
                                });
                              }
                            }),
                            vSpace(60)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      color: AppColor.primary,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text('Total Pesanan',style: whiteTextStyle,),
                          Text('${state.makanan.where((element) => element.jumlah>0).length+state.minuman.where((element) => element.jumlah>0).length} ITEM',style: whiteTextStyle.copyWith(fontWeight: bold),)
                        ],
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
