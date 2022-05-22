import 'package:carousel_slider/carousel_slider.dart';
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
import 'package:kopiek_resto/presentation/widgets/custom_outline_button.dart';
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
                      vSpace(10),
                      Text('Suasana dan Makanan',style: blackTextStyle.copyWith(fontWeight: bold,fontSize: 16),),
                      vSpace(10),
                      CarouselSlider.builder(
                        itemCount: 5,
                        itemBuilder: (context,index,j){
                          return Image.asset('assets/aset-${index+1}.jpg',fit: BoxFit.cover,);
                        },
                        options: CarouselOptions(
                            aspectRatio: 2,
                            viewportFraction: 1,
                            autoPlay: true
                        ),
                      ),
                      vSpace(10),
                      CustomOutlineButton(borderColor: AppColor.primary, label: 'Lihat di google maps', onPressed: (){
                        launchUrl(state.data.linkGmaps);
                      }),
                      vSpace(10),
                      Row(
                        children: [
                          Icon(Icons.place),
                          hSpace(10),
                          Expanded(child: Text('Jl. Raya Pekanbaru - Bangkinang, Koto Perambahan, Kec. Kampar Tim., Kabupaten Kampar, Riau 28458',style: blackTextStyle,)),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Icon(Icons.phone),
                      //     hSpace(10),
                      //     Expanded(child: Text('082283832',style: blackTextStyle,)),
                      //   ],
                      // ),
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
