import 'package:flutter/material.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';

class DashboardClient extends StatefulWidget {
  const DashboardClient({Key? key}) : super(key: key);

  @override
  _DashboardClientState createState() => _DashboardClientState();
}

class _DashboardClientState extends State<DashboardClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HI Pelanggan'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
             Card(
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10),
               ),
               elevation: 0,
               child: Container(
                 width: MediaQuery.of(context).size.width,
                 padding: const EdgeInsets.all(10),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text('Welcome to Kopiek Resto Apps',style: blackTextStyle.copyWith(fontSize: 16),),
                     vSpace(20),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         InkWell(
                           onTap:(){
                             Navigator.pushNamed(context, RouteList.order,arguments: 'take away');
                           },
                           child: Column(
                             children: [
                               Icon(Icons.local_shipping),
                               vSpace(10),
                               Text('Takeaway')
                             ],
                           ),
                         ),
                         InkWell(
                           onTap: (){
                             Navigator.pushNamed(context, RouteList.order,arguments: 'dine in');
                           },
                           child: Column(
                             children: [
                               Icon(Icons.restaurant),
                               vSpace(10),
                               Text('Dine in')
                             ],
                           ),
                         ),
                         InkWell(

                           child: Column(
                             children: [
                               Icon(Icons.receipt),
                               vSpace(10),
                               Text('Voucher')
                             ],
                           ),
                         ),
                         InkWell(
                           onTap: (){
                             Navigator.pushNamed(context, RouteList.riwayatPoin);
                           },
                           child: Column(
                             children: [
                               Icon(Icons.payments),
                               vSpace(10),
                               Text('My Point')
                             ],
                           ),
                         ),
                       ],
                     )
                   ],
                 ),
               ),
             )
            ],
          ),
        ),
      ),
    );
  }
}
