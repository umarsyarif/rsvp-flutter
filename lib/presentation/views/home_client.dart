import 'package:flutter/material.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/client/dashboard.dart';

class HomeClient extends StatefulWidget {
  final int index;
  const HomeClient({Key? key, this.index=0}) : super(key: key);

  @override
  _HomeClientState createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> with SingleTickerProviderStateMixin{
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
          BottomNavigationBarItem(icon: Icon(Icons.timeline),label: 'Tracking'),
          BottomNavigationBarItem(icon: Icon(Icons.travel_explore),label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.travel_explore),label: 'Account'),
        ],
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children:  [
          DashboardClient(),
          Text('oke'),
          Text('oke'),
          Text('oke'),
        ],
      ),
    );
  }
}
