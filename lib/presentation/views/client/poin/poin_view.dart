import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/data/models/menu_model.dart';
import 'package:kopiek_resto/data/models/riwayat_poin_model.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/presentation/blocs/client/riwayat-poin/riwayat_poin_bloc.dart';
import 'package:kopiek_resto/presentation/blocs/menu/menu_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';

class PoinView extends StatefulWidget {
  const PoinView({Key? key}) : super(key: key);

  @override
  _PoinViewState createState() => _PoinViewState();
}

class _PoinViewState extends State<PoinView> {

  late RiwayatPoinBloc _riwayatPoinBloc;

  @override
  void initState() {
    super.initState();
    _riwayatPoinBloc = di<RiwayatPoinBloc>();
    _riwayatPoinBloc.add(FetchRiwayatPoinEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _riwayatPoinBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>_riwayatPoinBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Riwayat Poin'),
        ),
        body: BlocBuilder<RiwayatPoinBloc,RiwayatPoinState>(
          builder: (contex,state){
            if(state is RiwayatPoinLoading){
              return const Center(child: LoadingCircle(),);
            }
            else if(state is RiwayatPoinFailure){
              return ErrorPage(label: state.message,onPressed: (){
                _riwayatPoinBloc.add(FetchRiwayatPoinEvent());
              },);
            }
            else if (state is RiwayatPoinLoaded){
              return Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.data.length,
                  itemBuilder: (context,index){
                    DataRiwayatPoin data = state.data[index];
                    return ListTile(
                      leading: const Icon(Icons.paid),
                      title: Text(valueRupiah(data.nominal),style: data.tipe=='plus'?greenTextStyle:redTextStyle,),
                      subtitle: Text(convertDateTime(data.createdAt.toLocal()),style: greyTextStyle,),
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
