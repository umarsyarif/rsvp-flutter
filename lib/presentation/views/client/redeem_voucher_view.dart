import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/domain/entities/update_menu_params.dart';
import 'package:kopiek_resto/presentation/blocs/admin/voucher/voucher_bloc.dart';
import 'package:kopiek_resto/presentation/blocs/client/redeem_voucher/redeem_voucher_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';

class RedeemVoucherView extends StatefulWidget {
  const RedeemVoucherView({Key? key}) : super(key: key);

  @override
  _RedeemVoucherViewState createState() => _RedeemVoucherViewState();
}

class _RedeemVoucherViewState extends State<RedeemVoucherView> {

  late RedeemVoucherBloc _voucherBloc;

  @override
  void initState() {
    super.initState();
    _voucherBloc = di<RedeemVoucherBloc>();
    _voucherBloc.add(FetchRedeemVoucherEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _voucherBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voucher'),
      ),
      body: BlocProvider(
        create: (_)=>_voucherBloc,
        child: BlocConsumer<RedeemVoucherBloc,RedeemVoucherState>(
          listener: (context,state){
            if(state is RedeemVoucherLoaded){
              if(state.status==Status.failure){
                EasyLoading.showError('Terjadi kesalahan ketika redeem voucher');
              }else if(state.status==Status.success){
                EasyLoading.showSuccess('Berhasil memakai voucher');
              }
            }
          },
          builder: (context,state){
            if(state is RedeemVoucherFailure){
              return ErrorPage(label: state.message, onPressed: (){
                _voucherBloc.add(FetchRedeemVoucherEvent());
              });
            }else if(state is RedeemVoucherLoading){
              return const Center(child:LoadingCircle());
            }else if(state is RedeemVoucherLoaded){
              return Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: state.data.length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    DataVoucher data = state.data[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.network(data.foto),),
                        vSpace(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data.label,style: greyTextStyle,),
                                Text('${data.diskon}%',style: blackTextStyle,),
                                state.claimed!=null&&state.claimed!.id==data.id?Chip(label:  Text('Dipakai',style: whiteTextStyle,),backgroundColor: AppColor.primary,)
                                    :ActionChip(label: Text('Pakai Voucher',style: primaryTextStyle,), onPressed: (){
                                      _voucherBloc.add(SaveRedeemVoucherEvent(data),
                                      );
                                },backgroundColor: Colors.white,shape: StadiumBorder(side: BorderSide(color: AppColor.primary)),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        vSpace(10),
                      ],
                    );
                  },
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
