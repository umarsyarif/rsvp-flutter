import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/extension/image_pick_helper.dart';
import 'package:kopiek_resto/common/utils/form_validation.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/data/models/menu_model.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/domain/entities/menu_params.dart';
import 'package:kopiek_resto/presentation/blocs/admin/update-menu/update_menu_bloc.dart';
import 'package:kopiek_resto/presentation/blocs/menu/menu_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/custom_flat_button.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';
import 'package:kopiek_resto/presentation/widgets/text_fied_widget.dart';

class UpdateMenuView extends StatefulWidget {
  final DataMenu menu;
  const UpdateMenuView({Key? key, required this.menu}) : super(key: key);

  @override
  _UpdateMenuViewState createState() => _UpdateMenuViewState();
}

class _UpdateMenuViewState extends State<UpdateMenuView> {
  late UpdateMenuBloc _menuBloc;
  TextEditingController nama =TextEditingController();
  String foto='';
  TextEditingController harga =TextEditingController();
  TextEditingController diskon =TextEditingController();
  TextEditingController stok =TextEditingController();
  String? idSatuan,jenis;
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _menuBloc = di<UpdateMenuBloc>();
    _menuBloc.add(FetchUpdateMenuEvent());
    nama.text = widget.menu.nama;
    foto = widget.menu.foto;
    harga.text = valueRupiah(widget.menu.harga).toString();
    diskon.text = widget.menu.diskon.toString();
    idSatuan = widget.menu.idSatuan.toString();
  }

  @override
  void dispose() {
    super.dispose();
    _menuBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>_menuBloc,
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Ubah ${widget.menu.nama}'),
        ),
        body: BlocConsumer<UpdateMenuBloc,UpdateMenuState>(
          listener: (context,state){
            if(state is UpdateMenuLoaded){
              if(state.status == Status.failure){
                EasyLoading.showError(state.errMessage);
              }else if (state.status == Status.success){
                EasyLoading.showSuccess('Berhasil merubah menu');
                Navigator.pushNamedAndRemoveUntil(context, RouteList.homeAdmin, (route) => false);
              }
            }
          },
          builder: (context,state){
            if(state is UpdateMenuLoading){
              return const Center(child:LoadingCircle());
            }else if(state is UpdateMenuFailure){
              return ErrorPage(label: state.message,onPressed: (){
                _menuBloc.add(FetchUpdateMenuEvent());
              },);
            }else if(state is UpdateMenuLoaded){
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFieldWidget(
                          hintText: 'Nama',
                          controller: nama,
                          validator: (value) =>
                              FormValidation.validate(value.toString(), label: 'Nama'),
                        ),
                        vSpace(10),
                        // DropdownButtonFormField(
                        //   hint: const Text('Jenis'),
                        //   items: ['makanan','minuman'].map((e) => DropdownMenuItem(child: Text(e),value: e,)).toList(),
                        //   value: jenis,
                        //   validator: (value)=>FormValidation.validate(value?.toString()??'',label: 'Jenis'),
                        //   decoration: inputDecoration,
                        //   onChanged: (value){
                        //     jenis = value.toString();
                        //     setState(() {
                        //
                        //     });
                        //   },
                        // ),
                        // vSpace(10),
                        DropdownButtonFormField(
                          hint: const Text('Satuan'),
                          items: state.satuan.map((e) => DropdownMenuItem(child: Text(e.nama),value: e.id.toString(),)).toList(),
                          value: idSatuan,
                          onChanged: (value){
                            idSatuan = value.toString();
                            setState(() {

                            });
                          },
                          decoration: inputDecoration,
                          validator: (value)=>FormValidation.validate(value?.toString()??'',label: 'Satuan'),
                        ),
                        vSpace(10),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: harga,
                          decoration: inputDecoration.copyWith(hintText: 'Harga'),
                          inputFormatters:  [
                            FilteringTextInputFormatter.digitsOnly,
                            CurrencyInputFormatter()
                          ],
                          validator: (value) =>
                              FormValidation.validate(value.toString(), label: 'Harga'),
                        ),
                        vSpace(10),
                        TextFieldWidget(
                          hintText: 'Diskon',
                          typeInput: TextInputType.number,
                          maxLength: 2,
                          controller: diskon,
                          validator: (value) =>
                              FormValidation.validate(value.toString(), label: 'Diskon'),
                        ),

                        // vSpace(10),
                        // TextFieldWidget(
                        //   hintText: 'Stok',
                        //   typeInput: TextInputType.number,
                        //   controller: stok,
                        //   validator: (value) =>
                        //       FormValidation.validate(value.toString(), label: 'Stok'),
                        // ),

                        vSpace(10),
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
                                  foto.contains('https')?Image.network(foto): Image.file(File(foto)),
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
                            if(foto.isEmpty){
                              EasyLoading.showError('Foto belum ditambahkan');
                            }
                            else if(_form.currentState?.validate()??false){
                              _menuBloc.add(PostUpdateMenuEvent(
                                MenuParams(nama.text, foto, idSatuan!, widget.menu.tipe, int.parse(valueNoRp(harga.text)), int.parse(diskon.text), widget.menu.stok.jumlah,id: widget.menu.id.toString())
                              ));
                            }
                          },
                          label: 'Ubah',
                        )
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
  }
}
class DialogFoto extends StatelessWidget {
  const DialogFoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Pilih dari kamera'),
            onTap: (){
              ImagePickerHelper.getImage(ImageSource.camera).then((value) {
                if(value!=null){
                  Navigator.pop(context, value.toString());
                }
              });
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.collections),
            title: const Text('Pilih dari galeri'),
            onTap: (){
              ImagePickerHelper.getImage(ImageSource.gallery).then((value) {
                if(value!=null){
                  Navigator.pop(context, value.toString());
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

