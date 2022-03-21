import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/utils/form_validation.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/domain/entities/order_params.dart';
import 'package:kopiek_resto/presentation/blocs/admin/konfigurasi/konfigurasi_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/custom_flat_button.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';
import 'package:kopiek_resto/presentation/widgets/text_fied_widget.dart';

class OrderView extends StatefulWidget {
  final String jenis;
  const OrderView({Key? key, required this.jenis}) : super(key: key);

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  TextEditingController jumlahPelaggan = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  TextEditingController jam = TextEditingController();
  final _form = GlobalKey<FormState>();
  late KonfigurasiBloc _konfigurasiBloc;

  @override
  void initState() {
    super.initState();
    _konfigurasiBloc = di<KonfigurasiBloc>();
    _konfigurasiBloc.add(FetchKonfigurasiEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _konfigurasiBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>_konfigurasiBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order'),
        ),
        body: BlocBuilder<KonfigurasiBloc,KonfigurasiState>(
          builder:(context,state){
            if(state is KonfigurasiLoading){
              return const Center(child:LoadingCircle());
            }else if(state is KonfigurasiFailure){
              return ErrorPage(label: state.message,onPressed: (){
                _konfigurasiBloc.add(FetchKonfigurasiEvent());
              },);
            }else if(state is KonfigurasiLoaded){
              return  SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key:_form,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(10),
                            decoration:BoxDecoration(
                              color: Colors.yellow[900],
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.info,color: Colors.white,),
                                hSpace(10),
                                Text('Jam Operasional ${state.data.buka.substring(0,5)} - ${state.data.tutup.substring(0,5)}',style: whiteTextStyle.copyWith(fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                          TextFieldWidget(
                              hintText: 'Jumlah Orang',
                              typeInput: TextInputType.number,
                              controller: jumlahPelaggan,
                            validator: (value)=>FormValidation.validate(value.toString(),label: 'Jumlah Orang'),
                            maxLength: 2,
                          ),
                          vSpace(10),
                          TextFieldWidget(
                            hintText: 'Jadwal',
                            readonly: true,
                            controller: tanggal,
                              validator: (value)=>FormValidation.validate(value.toString(),label: 'Tanggal'),
                            onTap:(){
                              showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(const Duration(days: 30))).then((value){
                                    if(value!=null){
                                      tanggal.text = dbDateFormat(value);
                                    }
                              });
                            }
                          ),
                          vSpace(10),
                          TextFieldWidget(
                            hintText: 'Jam',
                              readonly: true,
                              controller: jam,
                              validator: (value)=>FormValidation.validate(value.toString(),label: 'Jam'),
                              onTap:(){
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode: TimePickerEntryMode.dial,
                                  builder: (context,child){
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                      child: child!,
                                    );
                                  }
                                ).then((value){
                                  if(value!=null){
                                    if(value.hour>=int.parse(state.data.buka.substring(0,2))&&value.hour<int.parse(state.data.tutup.substring(0,2))){
                                      jam.text = '${value.hour.toString().length==1?'0${value.hour}':value.hour}:${value.minute.toString().length==1?'0${value.minute}':value.minute}';
                                    }else{
                                      EasyLoading.showError('Waktu yang dipilih diluar jam operasional');
                                    }
                                  }
                                });
                              }
                          ),
                          vSpace(20),
                          CustomFlatButton(backgroundColor: AppColor.primary, label: 'SIMPAN', onPressed: (){
                            if(_form.currentState?.validate()??false){
                                  Navigator.pushNamed(context, RouteList.detailOrder,
                                      arguments: OrderParams(widget.jenis, tanggal.text,
                                          jam.text, int.parse(jumlahPelaggan.text)));
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text ('Order ${widget.jenis}'),
    //   ),

    // );
  }
}
