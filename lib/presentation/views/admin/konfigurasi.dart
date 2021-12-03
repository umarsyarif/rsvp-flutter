import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/presentation/blocs/admin/konfigurasi/konfigurasi_bloc.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';

class KonfigurasiView extends StatefulWidget {
  const KonfigurasiView({Key? key}) : super(key: key);

  @override
  _KonfigurasiViewState createState() => _KonfigurasiViewState();
}

class _KonfigurasiViewState extends State<KonfigurasiView> {
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
          title: const Text('Pengaturan'),
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
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.timer),
                        title: Text('Jam Buka'),
                        trailing: Text(state.data.buka),
                      ),
                      ListTile(
                        leading: Icon(Icons.timer),
                        title: Text('Jam Tutup'),
                        trailing: Text(state.data.tutup),
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
