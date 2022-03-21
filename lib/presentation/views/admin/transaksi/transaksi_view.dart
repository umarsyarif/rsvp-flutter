import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/utils/form_validation.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/data/models/order_model.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/presentation/blocs/admin/order/order_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/custom_flat_button.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';
import 'package:kopiek_resto/presentation/widgets/text_fied_widget.dart';

class TransaksiView extends StatefulWidget {
  final String status;
  const TransaksiView({Key? key, required this.status}) : super(key: key);

  @override
  _TransaksiViewState createState() => _TransaksiViewState();
}

class _TransaksiViewState extends State<TransaksiView> {
  late OrderBloc _orderBloc;

  @override
  void initState() {
    super.initState();
    _orderBloc = di<OrderBloc>();
    _orderBloc.add(FetchOrderEvent(widget.status));
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
        body: BlocBuilder<OrderBloc,OrderState>(
          builder: (context,state){
            if(state is OrderLoading){
              return const Center(child: LoadingCircle());
            }else if (state is OrderFailure){
              return ErrorPage(label: state.message,onPressed: (){
                _orderBloc.add(FetchOrderEvent(widget.status));
              });
            }else if (state is OrderLoaded){
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.start.isEmpty?ActionChip(label: Text(currentMonth),onPressed: (){
                        showModalBottomSheet(context: context, builder: (context)=>const DateFilter())
                        .then((value){
                          if(value!=null){
                            _orderBloc.add(FetchOrderEvent(widget.status,start: value['start'],end: value['end']));
                          }
                        });
                      },):Chip(
                        label: Text('${getDateDashboard(DateTime.parse(state.start))} - ${getDateDashboard(DateTime.parse(state.end))}'),
                        onDeleted: (){
                          _orderBloc.add(FetchOrderEvent(widget.status));
                        },
                      ),
                      state.data.isEmpty?const Center(child:Text('Data belum ada')): ListView.builder(
                        itemCount: state.data.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          DataOrder order = state.data[index];
                          return ListTile(
                            title: Text('${order.tipe} (${order.detailOrder.length} item)'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(valueRupiah(order.total),style: blackTextStyle.copyWith(fontWeight: bold),),
                                Text('${order.jam.substring(0,5)} / ${getDateDashboard(order.tanggal)}'),
                              ],
                            ),
                            trailing: Chip(label: Text(order.statusOrder[0].status,style: whiteTextStyle,),backgroundColor: AppColor.primary,),
                            onTap: (){
                              Navigator.pushNamed(context, RouteList.detailOrderAdmin,arguments: order.id);
                            },
                          );
                        },
                      ),
                    ],
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
class DateFilter extends StatefulWidget {
  const DateFilter({Key? key}) : super(key: key);

  @override
  _DateFilterState createState() => _DateFilterState();
}

class _DateFilterState extends State<DateFilter> {
  late TextEditingController start,end;
  final _form = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    start = TextEditingController();
    end = TextEditingController();
  }
  @override
  void dispose() {
    super.dispose();
    start.dispose();
    end.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFieldWidget(
              hintText: 'Tanggal Mulai',
              controller: start,
              readonly: true,
              validator: (value)=>FormValidation.validate(value??'',label:'Tanggal mulai'),
              onTap: (){
                showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now().subtract(const Duration(days: 365)), lastDate: DateTime.now().add(const Duration(days: 365)))
                .then((value){
                  if(value!=null){
                    start.text = getDateForFilter(value);
                  }
                });
              },
            ),
            vSpace(20),
            TextFieldWidget(
              hintText: 'Tanggal Selesai',
              controller: end,
              readonly: true,
              validator: (value)=>FormValidation.validate(value??'',label:'Tanggal selesai'),
              onTap: (){
                showDatePicker(context: context, initialDate: start.text.isNotEmpty?DateTime.parse(start.text):DateTime.now(), firstDate:start.text.isNotEmpty?DateTime.parse(start.text):DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)))
                    .then((value){
                  if(value!=null){
                    end.text = getDateForFilter(value);
                  }
                });
              },
            ),
            vSpace(20),
            CustomFlatButton(backgroundColor: AppColor.primary, label: 'SIMPAN', onPressed: (){
              if(_form.currentState?.validate()??false){
                if(DateTime.parse(start.text).isBefore(DateTime.parse(end.text).add(Duration(days: 1)))){
                    Navigator.pop(
                        context, {'start': start.text, 'end': end.text});
                  }else{
                  EasyLoading.showError('Tanggal mulai tidak boleh setelah tanggal selesai');
                }
                }
                },
            ),
          ],
        ),
      ),
    );
  }
}

