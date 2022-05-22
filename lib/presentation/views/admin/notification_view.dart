import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/presentation/blocs/notifikasi/notifikasi_bloc.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  late NotifikasiBloc notifikasiBloc;

  @override
  void initState() {
    super.initState();
    notifikasiBloc = di<NotifikasiBloc>();
    notifikasiBloc.add(FetchNotifikasiEvent());
  }

  @override
  void dispose() {
    super.dispose();
    notifikasiBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>notifikasiBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Daftar Notfikasi'),
        ),
        body: BlocBuilder<NotifikasiBloc,NotifikasiState>(
          builder:(context,state){
            if(state is NotifikasiLoading){
              return const Center(child: LoadingCircle(),);
            }else if(state is NotifikasiFailure){
              return ErrorPage(
                label:state.message,
                onPressed: (){
                  notifikasiBloc.add(FetchNotifikasiEvent());
                },
              );
            }else if(state is NotifikasiLoaded){
              return SingleChildScrollView(
                child: Column(
                  children:state.data.map((e) => Container(
                    color:e.seen==0?Colors.grey[300]:Colors.white,
                    child: ListTile(
                      title: Text(e.isi),
                      subtitle: Text(convertDateDMMmYyyy(e.createdAt)),
                      leading: const Icon(Icons.notifications),
                      onTap: (){
                        notifikasiBloc.add(ReadNotifikasi(e.id));
                        if(e.type=='Order'){
                          Navigator.pushNamed(context, RouteList.detailOrderAdmin,arguments: jsonDecode(e.keterangan)['id_order']).then((value) => notifikasiBloc.add(FetchNotifikasiEvent()));
                        }
                      },
                    ),
                  )).toList(),
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
