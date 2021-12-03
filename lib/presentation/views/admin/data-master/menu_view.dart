import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/data/models/menu_model.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/presentation/blocs/menu/menu_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';

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
        body: BlocBuilder<MenuBloc,MenuState>(
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
                    return ListTile(
                      title: Text(data.nama),
                      trailing: Chip(label: Text(data.tipe)),
                      subtitle: Text(valueRupiah(data.harga)),
                      leading: Image.network(data.foto),
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
