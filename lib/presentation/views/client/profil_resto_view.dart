import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/extension/url_launcher_helper.dart';
import 'package:kopiek_resto/common/utils/form_validation.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/presentation/blocs/admin/konfigurasi/konfigurasi_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/custom_flat_button.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';
import 'package:kopiek_resto/presentation/widgets/text_fied_widget.dart';

class ProfilRestoranView extends StatefulWidget {
  const ProfilRestoranView({Key? key}) : super(key: key);

  @override
  _ProfilRestoranViewState createState() => _ProfilRestoranViewState();
}

class _ProfilRestoranViewState extends State<ProfilRestoranView> {
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
          title: const Text('Profil Restoran'),
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
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.data.profil,style: blackTextStyle,textAlign: TextAlign.justify,),
                      ActionChip(label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.location_on,color: AppColor.primary,),
                          hSpace(8),
                          Text('Lihat di gooogle maps',style: primaryTextStyle,),
                        ],
                      ), onPressed: (){
                        launchUrl(state.data.linkGmaps);
                      },
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: AppColor.primary),
                      )
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
