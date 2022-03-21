import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/presentation/blocs/admin/konfigurasi/konfigurasi_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/custom_flat_button.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';
import 'package:kopiek_resto/presentation/widgets/text_fied_widget.dart';

class JadwalRestoranView extends StatefulWidget {
  const JadwalRestoranView({Key? key}) : super(key: key);

  @override
  _JadwalRestoranViewState createState() => _JadwalRestoranViewState();
}

class _JadwalRestoranViewState extends State<JadwalRestoranView> {
  late KonfigurasiBloc _konfigurasiBloc;
  late TextEditingController jamBuka,jamTutup;

  @override
  void initState() {
    super.initState();
    _konfigurasiBloc = di<KonfigurasiBloc>();
    _konfigurasiBloc.add(FetchKonfigurasiEvent());
    jamBuka = TextEditingController();
    jamTutup = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _konfigurasiBloc.close();
    jamBuka.dispose();
    jamTutup.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>_konfigurasiBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Jadwal Restoran'),
        ),
        body: BlocConsumer<KonfigurasiBloc,KonfigurasiState>(
          listener:(context,state){
            if(state is KonfigurasiLoaded){
              if(state.status== Status.failure){
                EasyLoading.showError(state.errMessage);
              }else if (state.status == Status.success){
                EasyLoading.showSuccess('Berhasil mengubah konfigurasi');
                Navigator.pushNamedAndRemoveUntil(context, RouteList.homeAdmin, (route) => false,arguments: 3);
              }
            }
          },
          builder:(context,state){
            if(state is KonfigurasiLoading){
              return const Center(child:LoadingCircle());
            }else if(state is KonfigurasiFailure){
              return ErrorPage(label: state.message,onPressed: (){
                _konfigurasiBloc.add(FetchKonfigurasiEvent());
              },);
            }else if(state is KonfigurasiLoaded){
              jamBuka.text = state.data.buka.substring(0,5);
              jamTutup.text = state.data.tutup.substring(0,5);
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jam Buka'),
                      vSpace(5),
                      TextFieldWidget(
                        hintText: 'Jam Buka',
                        readonly: true,
                        controller: jamBuka,
                        prefixIcon: Icon(Icons.alarm),
                        onTap: (){
                          showTimePicker(context: context, initialTime: TimeOfDay(hour: int.parse(jamBuka.text.substring(0,2)), minute: int.parse(jamBuka.text.substring(3,5))))
                          .then((value){
                            if(value!=null){
                              jamBuka.text = value.format(context);
                            }
                          });
                        },
                      ),
                      vSpace(10),
                      Text('Jam tutup'),
                      vSpace(5),
                      TextFieldWidget(
                          hintText: 'Jam Tutup',
                          prefixIcon: Icon(Icons.alarm),
                          controller: jamTutup,
                          readonly: true,
                          onTap: (){
                            showTimePicker(context: context, initialTime: TimeOfDay(hour: int.parse(jamTutup.text.substring(0,2)), minute: int.parse(jamTutup.text.substring(3,5))))
                            .then((value){
                              if(value!=null){
                                jamTutup.text = value.format(context);
                              }
                            });
                          }
                      ),
                      vSpace(20),
                      CustomFlatButton(backgroundColor: AppColor.primary, label: 'SIMPAN', onPressed: (){
                        _konfigurasiBloc.add(UbahKonfigurasiEvent(jamBuka.text, jamTutup.text));
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
