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
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';

class VoucherView extends StatefulWidget {
  const VoucherView({Key? key}) : super(key: key);

  @override
  _VoucherViewState createState() => _VoucherViewState();
}

class _VoucherViewState extends State<VoucherView> {

  late VoucherBloc _voucherBloc;

  @override
  void initState() {
    super.initState();
    _voucherBloc = di<VoucherBloc>();
    _voucherBloc.add(FetchAllVoucherEvent());
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
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Navigator.pushNamed(context, RouteList.tambahVoucher);
      }, label: const Text('TAMBAH'),icon:const Icon(Icons.add),backgroundColor: AppColor.primary,),
      body: BlocProvider(
        create: (_)=>_voucherBloc,
        child: BlocConsumer<VoucherBloc,VoucherState>(
          listener: (context,state){
            if(state is VoucherLoaded){
              if(state.status==Status.failure){
                EasyLoading.showError(state.errMessage);
              }else if(state.status==Status.success){
                EasyLoading.showSuccess('Berhasil mengubah status');
              }
            }
          },
          builder: (context,state){
            if(state is VoucherFailure){
              return ErrorPage(label: state.message, onPressed: (){
                _voucherBloc.add(FetchAllVoucherEvent());
              });
            }else if(state is VoucherLoading){
              return const Center(child:LoadingCircle());
            }else if(state is VoucherLoaded){
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
                                Text(valueRupiah(data.diskon),style: blackTextStyle,),
                                ActionChip(label:  Text('Ubah Vuucher',style: whiteTextStyle,), onPressed: (){
                                  Navigator.pushNamed(context, RouteList.ubahVoucher,arguments: data);
                                },
                                  shape: const StadiumBorder(side: BorderSide(color: AppColor.primary)),
                                  backgroundColor: AppColor.primary,
                                ),
                              ],
                            ),
                            Switch(value: data.isActive==1, onChanged: (val){
                              _voucherBloc.add(UpdateVoucherEvent(UpdateActiveMenuParams(data.id,val?1:0)));
                            },
                              activeColor: AppColor.primary,
                            ),
                          ],
                        ),
                        const Divider(),
                        vSpace(10),
                        index==state.data.length-1?vSpace(50):const SizedBox.shrink(),
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
