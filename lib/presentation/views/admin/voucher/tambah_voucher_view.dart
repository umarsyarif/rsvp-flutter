import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/utils/form_validation.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/domain/entities/voucher_params.dart';
import 'package:kopiek_resto/presentation/blocs/admin/voucher/voucher_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/admin/data-master/tambah_menu.dart';
import 'package:kopiek_resto/presentation/widgets/custom_flat_button.dart';
import 'package:kopiek_resto/presentation/widgets/text_fied_widget.dart';

class TambahVoucherView extends StatefulWidget {
  const TambahVoucherView({Key? key}) : super(key: key);

  @override
  _TambahVoucherViewState createState() => _TambahVoucherViewState();
}

class _TambahVoucherViewState extends State<TambahVoucherView> {
  final _form =  GlobalKey<FormState>();
  TextEditingController label = TextEditingController();
  TextEditingController diskon = TextEditingController();
  String foto = '';
  late VoucherBloc _voucherBloc;

  @override
  void initState() {
    super.initState();
    _voucherBloc = di<VoucherBloc>();
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
        title: const Text('Tambah Voucher'),
      ),
      body: BlocProvider(
        create: (_)=>_voucherBloc,
        child: BlocListener<VoucherBloc,VoucherState>(
          listener: (context,state){
            if(state is VoucherFailure){
              EasyLoading.showError(state.message);
            }else if (state is VoucherCreated){
              EasyLoading.showSuccess('Berhasil menambah voucher');
              Navigator.pushNamedAndRemoveUntil(context, RouteList.tambahVoucher, (route) => false);
            }
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    TextFieldWidget(
                      hintText: 'label',
                      controller: label,
                      validator: (value) =>
                          FormValidation.validate(value.toString(), label: 'Label'),
                    ),
                    vSpace(10),

                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: diskon,
                      decoration: inputDecoration.copyWith(hintText: 'Diskon (dalam rupiah)'),
                      inputFormatters:  [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter()
                      ],
                      validator: (value) =>
                          FormValidation.validate(value.toString(), label: 'Harga'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: InkWell(
                        onTap: () async {
                          if(foto.isEmpty){
                            showDialog(context: context, builder: (context)=>const DialogFoto()).then((value){
                              if(value!=null){
                                foto = value.toString();
                                setState(() {

                                });
                              }
                            });
                          }
                        },
                        child:Card(
                          color: Colors.white,
                          child: foto.isNotEmpty?Stack(
                            children: [
                              Image.file(File(foto)),
                              Positioned(
                                  top:5,
                                  right:5,
                                  child:IconButton(
                                      icon: const CircleAvatar(
                                        child: Icon(Icons.delete,color: Colors.red,),
                                        backgroundColor: Colors.white,
                                      ),
                                      onPressed:(){
                                        foto = '';
                                        setState((){});
                                      }
                                  )
                              )
                            ],
                          ):AspectRatio(
                            aspectRatio :1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.camera_alt,
                                  size: 40,
                                ),
                                vSpace(16),
                                Text(
                                  'Tambahkan Foto Menu',
                                  style: blackTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    vSpace(20),
                    CustomFlatButton(
                      backgroundColor: AppColor.primary,
                      onPressed: (){
                        if(_form.currentState?.validate()??false){
                          _voucherBloc.add(CreateVoucherEvent(VoucherParams(label.text,foto,int.parse(valueNoRp(diskon.text)))));
                        }
                      },
                      label: 'Tambah',
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
