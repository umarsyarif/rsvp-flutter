import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/domain/entities/order_params.dart';
import 'package:kopiek_resto/domain/entities/pucrhase_order_params.dart';
import 'package:kopiek_resto/domain/entities/quantity_order_params.dart';
import 'package:kopiek_resto/presentation/blocs/client/checkout/checkout_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/custom_flat_button.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';
import 'package:kopiek_resto/presentation/widgets/text_fied_widget.dart';

class PurchaseOrderView extends StatefulWidget {
  final OrderParams orderParams;
  final List<QuantityOrderParams> makanan;
  final List<QuantityOrderParams> minuman;
  const PurchaseOrderView({Key? key, required this.orderParams, required this.makanan, required this.minuman}) : super(key: key);

  @override
  _PurchaseOrderViewState createState() => _PurchaseOrderViewState();
}

class _PurchaseOrderViewState extends State<PurchaseOrderView> {
  late CheckoutBloc _checkoutBloc;
  late int totalBayar;
  int diskon = 0;
  String? idVoucher;

  @override
  void initState() {
    super.initState();
    _checkoutBloc = di<CheckoutBloc>();
    _checkoutBloc.add(FetchChekcoutEvent());
    totalBayar = 0;

    for(var item in widget.makanan){
      totalBayar+=(item.jumlah*item.menu.harga);
    }
    for(var item in widget.minuman){
      totalBayar+=(item.jumlah*item.menu.harga);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _checkoutBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>_checkoutBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
        ),
        body: BlocConsumer<CheckoutBloc,CheckoutState>(
          listener: (context,state){
            if(state is CheckoutLoaded){
              if(state.status==Status.failure){
                EasyLoading.showError(state.errMessage);
              }else if (state.status==Status.success){
                EasyLoading.showSuccess('Berhasil checkout');
                Navigator.pushNamed(context, RouteList.makePayment,arguments: state.id).then((value){
                  Navigator.pushNamedAndRemoveUntil(context, RouteList.homeClient, (route) => false);
                });
              }
            }
          },
          builder: (context,state){
            if(state is CheckoutLoading){
              return const Center(child: LoadingCircle(),);
            }else if(state is CheckoutFailure){
              return ErrorPage(label: state.message, onPressed: (){
                _checkoutBloc.add(FetchChekcoutEvent());
              });
            }else if(state is CheckoutLoaded){
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              color: Colors.grey,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.orderParams.jenis.toUpperCase(),style: blackTextStyle.copyWith(fontWeight: bold),),
                                    Text('Disiapkan dalam waktu 35 menit',style: blackTextStyle,)
                                  ],
                                ),
                              ),
                            ),
                            vSpace(20),
                            widget.makanan.isEmpty?const SizedBox.shrink():Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Makanan',style: blackTextStyle.copyWith(fontWeight: bold),),
                                vSpace(10),
                                ListView.builder(
                                  itemCount: widget.makanan.length,
                                  shrinkWrap: true,
                                  physics:  const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context,index){
                                    QuantityOrderParams params = widget.makanan[index];
                                    return ListTile(
                                      title: Text(params.menu.nama),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${valueRupiah(params.menu.harga)}/${params.menu.satuan.nama}'),
                                          vSpace(10),
                                          TextFieldWidget(
                                            hintText: 'catatan',
                                            onChanged: (value){
                                              if(value!=null){
                                                widget.makanan[index].catatan = value;
                                                setState(() {

                                                });
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                      trailing: Text(params.jumlah.toString(),style: blackTextStyle.copyWith(fontWeight: bold),),
                                      leading: Image.network(params.menu.foto),
                                    );
                                  },
                                ),
                              ],
                            ),
                            vSpace(10),
                            widget.minuman.isEmpty?const SizedBox.shrink():Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Minuman',style: blackTextStyle.copyWith(fontWeight: bold),),
                                vSpace(10),
                                ListView.builder(
                                  itemCount: widget.minuman.length,
                                  shrinkWrap: true,
                                  physics:  const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context,index){
                                    QuantityOrderParams params = widget.minuman[index];
                                    return ListTile(
                                      title: Text(params.menu.nama),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${valueRupiah(params.menu.harga)}/${params.menu.satuan.nama}'),
                                          vSpace(10),
                                          TextFieldWidget(
                                            hintText: 'catatan',
                                            onChanged: (value){
                                              if(value!=null){
                                                widget.minuman[index].catatan = value;
                                                setState(() {

                                                });
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                      trailing: Text(params.jumlah.toString(),style: blackTextStyle.copyWith(fontWeight: bold),),
                                      leading: Image.network(params.menu.foto),
                                    );
                                  },
                                ),
                              ],
                            ),
                            vSpace(10),
                            state.data.isNotEmpty?Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: DropdownButtonFormField<String>(
                                    items: state.data.map((e) => DropdownMenuItem(child: Text('${e.label} - ${valueRupiah(e.diskon)}'),value: e.id.toString(),)).toList(),
                                    value: idVoucher,
                                    onChanged: (value){
                                      idVoucher = value;
                                      diskon = state.data.where((element) => element.id.toString()==value).first.diskon;
                                      setState(() {

                                      });
                                    },
                                    hint: const Text('Pilih Voucher'),
                                    decoration: inputDecoration,
                                  ),
                                ),
                                vSpace(10),
                              ],
                            ):const SizedBox(),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              color: Colors.grey,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Detail Pembayaran',style: blackTextStyle.copyWith(fontWeight: bold),),
                                    const Divider(thickness: 1,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Sub Total',style: blackTextStyle,),
                                        Text(valueRupiah(totalBayar))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Diskon',style: blackTextStyle,),
                                        Text(valueRupiah(diskon))
                                      ],
                                    ),
                                    const Divider(thickness: 1,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Harga',style: blackTextStyle,),
                                        Text(valueRupiah(totalBayar-diskon))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            vSpace(70),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(16),
                        child: CustomFlatButton(backgroundColor: AppColor.primary, label: 'CHECKOUT', onPressed: ()async{

                          PurchaseOrderParams params = PurchaseOrderParams(
                              idPengguna: state.user.id.toString(),
                              jumlah: widget.makanan.map((e) => e.jumlah).toList()..addAll(widget.minuman.map((e) => e.jumlah)),
                              jam: widget.orderParams.jam,
                              tanggal: widget.orderParams.tanggal,
                              tipe: widget.orderParams.jenis,
                              idMenu: widget.makanan.map((e) => e.menu.id.toString()).toList()..addAll(widget.minuman.map((e) => e.menu.id.toString())),
                              catatan: widget.makanan.map((e) => e.catatan).toList()..addAll(widget.minuman.map((e) => e.catatan)),
                              jumlahOrang: widget.orderParams.jumlahOrang,
                              idVoucher: idVoucher??'-');
                          // print(jsonEncode(params.toJson()));
                          _checkoutBloc.add(PostCheckout(params));
                        }),
                      ),
                    )
                  ],
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
