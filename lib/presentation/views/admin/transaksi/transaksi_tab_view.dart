import 'package:flutter/material.dart';
import 'package:kopiek_resto/presentation/views/admin/data-master/menu_view.dart';
import 'package:kopiek_resto/presentation/views/admin/data-master/satuan.dart';
import 'package:kopiek_resto/presentation/views/admin/transaksi/transaksi_view.dart';

class TransaksiTabView extends StatefulWidget {
  const TransaksiTabView({Key? key}) : super(key: key);

  @override
  _TransaksiTabViewState createState() => _TransaksiTabViewState();
}

class _TransaksiTabViewState extends State<TransaksiTabView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Transaksi'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              text: 'Diproses',
            ),
            Tab(
              text: 'Sudah Bayar',
            ),
            Tab(
              text: 'Selesai',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          TransaksiView(status: 'diproses'),
          TransaksiView(status: 'sudah bayar'),
          TransaksiView(status: 'selesai'),
        ],
      ),
    );
  }
}
