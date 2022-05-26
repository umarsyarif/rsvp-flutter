import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/utils/form_validation.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/presentation/blocs/admin/konfigurasi/konfigurasi_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/custom_flat_button.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';
import 'package:kopiek_resto/presentation/widgets/text_fied_widget.dart';

class KapasitasRestoranView extends StatefulWidget {
  const KapasitasRestoranView({Key? key}) : super(key: key);

  @override
  _KapasitasRestoranViewState createState() => _KapasitasRestoranViewState();
}

class _KapasitasRestoranViewState extends State<KapasitasRestoranView> {
  late KonfigurasiBloc _konfigurasiBloc;
  late TextEditingController kapasitasRestoran;
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _konfigurasiBloc = di<KonfigurasiBloc>();
    _konfigurasiBloc.add(FetchKonfigurasiEvent());
    kapasitasRestoran = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _konfigurasiBloc.close();
    kapasitasRestoran.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>_konfigurasiBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profil Restoran'),
        ),
        body: BlocConsumer<KonfigurasiBloc,KonfigurasiState>(
          listener:(context,state){
            if(state is KonfigurasiLoaded){
              if(state.status== Status.failure){
                EasyLoading.showError(state.errMessage);
              }else if (state.status == Status.success){
                EasyLoading.showSuccess('Berhasil mengubah konfigurasi');
                Navigator.pushNamedAndRemoveUntil(context, RouteList
                    .homeAdmin, (route) => false,arguments: 4);
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
              kapasitasRestoran.text = state.data.jumlahKursi.toString();
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Kapasitas Restoran'),
                        vSpace(5),
                        TextFieldWidget(
                          hintText: 'Kapasitas Restoran',
                          typeInput: TextInputType.number,
                          controller: kapasitasRestoran,
                          validator: (val)=>FormValidation.validate(val??'',
                              label: 'Kapasitas Restoran'),
                        ),
                        vSpace(10),
                        vSpace(20),
                        CustomFlatButton(backgroundColor: AppColor.primary, label: 'SIMPAN', onPressed: (){
                          if(_form.currentState?.validate()??false){
                            _konfigurasiBloc.add(UbahKapasitasRestoranEvent(int.parse(kapasitasRestoran.text)));
                          }
                        },
                        ),
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
