import 'package:flutter/material.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/admin/data-master/data_master_tab_view.dart';
import 'package:kopiek_resto/presentation/views/admin/data-master/menu_view.dart';
import 'package:kopiek_resto/presentation/views/admin/data-master/satuan.dart';
import 'package:kopiek_resto/presentation/views/admin/data-master/tambah_menu.dart';
import 'package:kopiek_resto/presentation/views/admin/konfigurasi.dart';
import 'package:kopiek_resto/presentation/views/admin/transaksi/transaksi_view.dart';

import 'dashboard_admin_view.dart';

class HomeAdmin extends StatefulWidget {
  final int index;
  const HomeAdmin({Key? key, this.index = 0}) : super(key: key);

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: widget.index);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColor.primary,
        onTap: (index){
          _tabController.index = index;
          setState(() {

          });
        },
        currentIndex: _tabController.index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.timeline),label: 'Transaksi'),
          BottomNavigationBarItem(icon: Icon(Icons.travel_explore),label: 'Data Master'),
          BottomNavigationBarItem(icon: Icon(Icons.travel_explore),label: 'Pengaturan'),
        ],
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children:  [
          DashboardAdminView(),
          TransaksiView(),
          const DataMasterTabView(),
          KonfigurasiView(),
        ],
      ),
    );
  }
}
