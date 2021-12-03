import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/data/models/order_model.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/presentation/blocs/admin/order/order_bloc.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';

class TransaksiView extends StatefulWidget {
  const TransaksiView({Key? key}) : super(key: key);

  @override
  _TransaksiViewState createState() => _TransaksiViewState();
}

class _TransaksiViewState extends State<TransaksiView> {
  late OrderBloc _orderBloc;

  @override
  void initState() {
    super.initState();
    _orderBloc = di<OrderBloc>();
    _orderBloc.add(FetchOrderEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _orderBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>_orderBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transaksi'),
        ),
        body: BlocBuilder<OrderBloc,OrderState>(
          builder: (context,state){
            if(state is OrderLoading){
              return const Center(child: LoadingCircle());
            }else if (state is OrderFailure){
              return ErrorPage(label: state.message,onPressed: (){
                _orderBloc.add(FetchOrderEvent());
              });
            }else if (state is OrderLoaded){
              return ListView.builder(
                itemCount: state.data.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  DataOrder order = state.data[index];
                  return ListTile(
                    title: Text('${order.tipe} (${order.detailOrder.length} item)'),
                    subtitle: Text('${order.jam}/${getDateDashboard(order.tanggal)}'),
                    trailing: Text(valueRupiah(order.total)),
                    onTap: (){
                      Navigator.pushNamed(context, RouteList.detailOrderAdmin,arguments: order.id);
                    },
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
