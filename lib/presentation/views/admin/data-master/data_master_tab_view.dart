import 'package:flutter/material.dart';
import 'package:kopiek_resto/presentation/views/admin/data-master/menu_view.dart';
import 'package:kopiek_resto/presentation/views/admin/data-master/satuan.dart';

class DataMasterTabView extends StatefulWidget {
  const DataMasterTabView({Key? key}) : super(key: key);

  @override
  _DataMasterTabViewState createState() => _DataMasterTabViewState();
}

class _DataMasterTabViewState extends State<DataMasterTabView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Data Master'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              text: 'Menu',
            ),
            Tab(
              text: 'Satuan',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          MenuView(),
          SatuanView(),
        ],
      ),
    );
  }
}
