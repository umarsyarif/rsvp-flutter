import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/di/get_it.dart';
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
        body: BlocBuilder<OrderBloc, OrderState>(
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
                                title: Text(state.data.tipe.toUpperCase()),
                                subtitle: Text(
                                    '${state.data.jam}/${getDateDashboard(state.data.tanggal)}'),
                                trailing: Text(valueRupiah(state.data.total)),
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
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      child: CustomOutlineButton(
                        onPressed: () {},
                        label: 'KONFIRMASI',
                        borderColor: AppColor.primary,
                      ),
                    ),
                  ),
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
