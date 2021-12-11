import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/domain/entities/update_status_params.dart';
import 'package:kopiek_resto/presentation/blocs/admin/order/order_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/custom_outline_button.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';

class DetailOrderAdminView extends StatefulWidget {
  final int id;
  const DetailOrderAdminView({Key? key, required this.id}) : super(key: key);

  @override
  _DetailOrderAdminViewState createState() => _DetailOrderAdminViewState();
}

class _DetailOrderAdminViewState extends State<DetailOrderAdminView> {
  late OrderBloc _orderBloc;

  @override
  void initState() {
    super.initState();
    _orderBloc = di<OrderBloc>();
    _orderBloc.add(FetchDetailOrderEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _orderBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail Order'),
        ),
        body: BlocConsumer<OrderBloc, OrderState>(
          listener: (context,state){
            if(state is OrderDetailLoaded){
              if(state.status == Status.success){
                if(state.user.role=='pelanggan'){
                  EasyLoading.showSuccess('Berhasil membayar pesanan');
                  Navigator.pushNamedAndRemoveUntil(context, RouteList.homeClient, (route) => false);
                }else{
                  EasyLoading.showSuccess('Berhasil menyelesaikan pesanan');
                  Navigator.pushNamedAndRemoveUntil(context, RouteList.homeAdmin, (route) => false);
                }
              }else if(state.status == Status.failure){
                EasyLoading.showError(state.errMessage);

              }
            }
          },
          builder: (context, state) {
            if (state is OrderLoading) {
              return const Center(child: LoadingCircle());
            } else if (state is OrderFailure) {
              return ErrorPage(
                  label: state.message,
                  onPressed: () {
                    _orderBloc.add(FetchDetailOrderEvent(widget.id));
                  });
            } else if (state is OrderDetailLoaded) {
              return Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                leading: const Icon(Icons.person),
                                title: Text(
                                    state.data.pengguna.nama),
                                subtitle: Text(state.data.pengguna.noHp),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                title: Text(state.data.tipe.toUpperCase()),
                                subtitle: Text(
                                    '${state.data.jam}/${getDateDashboard(state.data.tanggal)}'),
                                trailing: Text(valueRupiah(state.data.total),style:blackTextStyle.copyWith(fontWeight: bold)),
                              ),
                            ),
                            vSpace(20),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Column(
                                children: state.data.detailOrder
                                    .map((e) => Column(
                                          children: [
                                            ListTile(
                                              leading:ClipRRect(child: Image.network(e.menu.foto),borderRadius: BorderRadius.circular(10),),
                                              title: Text(e.menu.nama),
                                              subtitle: Text(
                                                  'catatan : ${e.catatan ?? '-'}'),
                                              trailing: Column(
                                                children: [
                                                  Text(
                                                      '${e.jumlah} ${e.menu.satuan.nama}'),
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                          ],
                                        ))
                                    .toList(),
                              ),
                            ),
                            vSpace(20),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Text(
                                    'STATUS',
                                    style:
                                    blackTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
                                  ),
                                  vSpace(8),
                                  Column(
                                    children: state.data.statusOrder
                                        .map((e) => Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          e.status,
                                          style: greyTextStyle.copyWith(fontSize: 12),
                                        ),
                                        Text(
                                          getDateDashboard(e.createdAt.toLocal()),
                                          style: greyTextStyle.copyWith(fontSize: 12),
                                        )
                                      ],
                                    ))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  state.user.role=='admin'&&state.data.statusOrder[0].status=='sudah bayar'? Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      child: CustomOutlineButton(
                        onPressed: () {
                          _orderBloc.add(UpdateStatusOrderEvent(UpdateStatusParams(state.data.id,'selesai')));
                        },
                        label: 'SELESAIKAN PESANAN',
                        borderColor: AppColor.primary,
                      ),
                    ),
                  ):const SizedBox(),
                  state.user.role=='pelanggan'&&(state.data.statusOrder[0].status=='diproses'||state.data.statusOrder[0].status=='reschedule')? Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      child: CustomOutlineButton(
                        onPressed: () {
                          _orderBloc.add(UpdateStatusOrderEvent(UpdateStatusParams(state.data.id,'sudah bayar')));
                        },
                        label: 'KONFIRMASI PEMBAYARAN',
                        borderColor: AppColor.primary,
                      ),
                    ),
                  ):const SizedBox(),
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
