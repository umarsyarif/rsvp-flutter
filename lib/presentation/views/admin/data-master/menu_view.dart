import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/utils/form_validation.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/data/models/menu_model.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/domain/entities/update_menu_params.dart';
import 'package:kopiek_resto/domain/entities/update_stok_params.dart';
import 'package:kopiek_resto/presentation/blocs/menu/menu_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/custom_flat_button.dart';
import 'package:kopiek_resto/presentation/widgets/dialog_gambar.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';
import 'package:kopiek_resto/presentation/widgets/text_fied_widget.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {

  late MenuBloc _menuBloc;

  @override
  void initState() {
    super.initState();
    _menuBloc = di<MenuBloc>();
    _menuBloc.add(FetchMenuEvent());
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
        floatingActionButton: FloatingActionButton.extended(onPressed: (){
          Navigator.pushNamed(context, RouteList.addMenu);
        }, label: const Text('TAMBAH'),backgroundColor: AppColor.primary,icon: const Icon(Icons.add),),
        body: BlocConsumer<MenuBloc,MenuState>(
          listener: (context,state){
            if(state is MenuLoaded){
              if(state.status == Status.failure){
                EasyLoading.showError(state.errMessage);
              }else if (state.status==Status.success){
                EasyLoading.showSuccess('Berhasil merubah status menu');
                _menuBloc.add(FetchMenuEvent());
              }
            }
          },
          builder: (contex,state){
            if(state is MenuLoading){
              return const Center(child: LoadingCircle(),);
            }
            else if(state is MenuFailure){
              return ErrorPage(label: state.message,onPressed: (){
                _menuBloc.add(FetchMenuEvent());
              },);
            }
            else if (state is MenuLoaded){
              return Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.menu.length,
                  itemBuilder: (context,index){
                    DataMenu data = state.menu[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(20),child: InkWell(onTap:(){
                              showGambar(context,data.foto);
                            },child: Image.network(data.foto,width: 100,)),),flex: 2,),
                            const Spacer(flex: 1,),
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.nama,style: greyTextStyle,),
                                  Text(valueRupiah(data.harga),style: blackTextStyle,),
                                  Text('Stok : ${data.stok.jumlah}',style: greyTextStyle,),
                                  ActionChip(label:  Text('Ubah Menu',style: whiteTextStyle,), onPressed: (){
                                    Navigator.pushNamed(context, RouteList.ubahMenu,arguments: data);
                                  },
                                    shape: const StadiumBorder(side: BorderSide(color: AppColor.primary)),
                                    backgroundColor: AppColor.primary,
                                  ),
                                  ActionChip(label:  Text('Ubah Stok',style: primaryTextStyle.copyWith(color: AppColor.primary),), onPressed: (){
                                    TextEditingController stok = TextEditingController(text:data.stok.jumlah.toString());
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                      ),
                                      builder: (context)=> Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFieldWidget(
                                              hintText: 'Stok',
                                              controller: stok,
                                              typeInput: TextInputType.number,
                                              validator: (value) =>
                                                  FormValidation.validate(value.toString(), label: 'Nama'),
                                            ),
                                            vSpace(20),
                                            CustomFlatButton(backgroundColor: AppColor.primary, label: 'SIMPAN', onPressed: (){
                                              Navigator.pop(context);
                                              _menuBloc.add(UpdateStokMenuEvent(UpdateStokParams(data.id.toString(),stok.text)));
                                            }),
                                            Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
                                          ],
                                        ),
                                      )
                                    );
                                  },
                                    shape: const StadiumBorder(side: BorderSide(color: AppColor.primary)),
                                    backgroundColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Switch(value: data.isActive==1, onChanged: (val){
                                _menuBloc.add(UpdateActiveMenuEvent(UpdateActiveMenuParams(data.id, val?1:0)));
                              },
                                activeColor: AppColor.primary,
                              ),
                            ),
                          ],
                        ),
                        vSpace(10),
                        const Divider(),
                        index==state.menu.length-1?vSpace(50):const SizedBox.shrink(),
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
