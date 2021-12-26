import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/presentation/blocs/admin/voucher/voucher_bloc.dart';
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
        child: BlocBuilder<VoucherBloc,VoucherState>(
          builder: (context,state){
            if(state is VoucherFailure){
              return ErrorPage(label: state.message, onPressed: (){
                _voucherBloc.add(FetchAllVoucherEvent());
              });
            }else if(state is VoucherLoading){
              return const Center(child:LoadingCircle());
            }else if(state is VoucherLoaded){
              return ListView.builder(
                itemCount: state.data.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  DataVoucher data = state.data[index];
                  return ListTile(
                    title: Text(data.label),
                    trailing: Text(valueRupiah(data.diskon)),
                    leading: Image.network(data.foto),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
