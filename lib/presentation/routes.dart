import 'package:flutter/material.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/data/models/menu_model.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';
import 'package:kopiek_resto/domain/entities/order_params.dart';
import 'package:kopiek_resto/presentation/views/admin/data-master/data_master_tab_view.dart';
import 'package:kopiek_resto/presentation/views/admin/data-master/tambah_menu.dart';
import 'package:kopiek_resto/presentation/views/admin/data-master/update_menu_view.dart';
import 'package:kopiek_resto/presentation/views/admin/data-master/update_voucher_view.dart';
import 'package:kopiek_resto/presentation/views/admin/home.dart';
import 'package:kopiek_resto/presentation/views/admin/jadwal_restoran.dart';
import 'package:kopiek_resto/presentation/views/admin/kapasitas_restoran.dart';
import 'package:kopiek_resto/presentation/views/admin/notification_view.dart';
import 'package:kopiek_resto/presentation/views/admin/order/detail_order_admin_view.dart';
import 'package:kopiek_resto/presentation/views/admin/profil_restoran.dart';
import 'package:kopiek_resto/presentation/views/admin/voucher/tambah_voucher_view.dart';
import 'package:kopiek_resto/presentation/views/client/order/detail_order_view.dart';
import 'package:kopiek_resto/presentation/views/client/order/order_view.dart';
import 'package:kopiek_resto/presentation/views/client/order/purchase_order_view.dart';
import 'package:kopiek_resto/presentation/views/client/order/web_payment_view.dart';
import 'package:kopiek_resto/presentation/views/client/poin/poin_view.dart';
import 'package:kopiek_resto/presentation/views/client/profil_resto_view.dart';
import 'package:kopiek_resto/presentation/views/client/redeem_voucher_view.dart';
import 'package:kopiek_resto/presentation/views/home_client.dart';
import 'package:kopiek_resto/presentation/views/login_view.dart';
import 'package:kopiek_resto/presentation/views/register.dart';
import 'package:kopiek_resto/presentation/views/splash_screen.dart';

class AppRouter{
  Route? onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteList.splash:
        return MaterialPageRoute(builder: (_)=>const SplashScreen());
      case RouteList.login:
        return MaterialPageRoute(builder: (_)=>const LoginView());
      case RouteList.homeAdmin:
        return MaterialPageRoute(builder: (_)=> HomeAdmin(index: settings.arguments==null?0:settings.arguments as int,));
      case RouteList.homeClient:
        return MaterialPageRoute(builder: (_)=> HomeClient());
      case RouteList.register:
        return MaterialPageRoute(builder: (_)=>const RegisterView());
      case RouteList.addMenu:
        return MaterialPageRoute(builder: (_)=>const TambahMenu());
      case RouteList.order:
        return MaterialPageRoute(builder: (_)=> OrderView(jenis: settings.arguments.toString(),));
      case RouteList.detailOrder:
        return MaterialPageRoute(builder: (_)=> DetailOrderView(params: settings.arguments as OrderParams,));
      case RouteList.detailOrderAdmin:
        return MaterialPageRoute(builder: (_)=> DetailOrderAdminView(id: settings.arguments as int,));
      case RouteList.riwayatPoin:
        return MaterialPageRoute(builder: (_)=> PoinView());
      case RouteList.makePayment:
        return MaterialPageRoute(builder: (_)=> WebPaymentView(id: settings.arguments.toString(),));
      case RouteList.tambahVoucher:
        return MaterialPageRoute(builder: (_)=> const TambahVoucherView());
      case RouteList.dataMaster:
        return MaterialPageRoute(builder: (_)=> const DataMasterTabView());
      case RouteList.notifkasi:
        return MaterialPageRoute(builder: (_)=> const NotificationView());
      case RouteList.jadwalRestoran:
        return MaterialPageRoute(builder: (_)=> const JadwalRestoranView());
      case RouteList.ubahMenu:
        return MaterialPageRoute(builder: (_)=>  UpdateMenuView(menu: settings.arguments! as DataMenu));
      case RouteList.ubahVoucher:
        return MaterialPageRoute(builder: (_)=>  UpdateVoucherView(voucher: settings.arguments! as DataVoucher));
      case RouteList.redeemVoucher:
        return MaterialPageRoute(builder: (_)=> const RedeemVoucherView());
      case RouteList.ubahProfilResto:
        return MaterialPageRoute(builder: (_)=> const UbahProfilRestoranView());
      case RouteList.lihatProfilResto:
        return MaterialPageRoute(builder: (_)=> const ProfilRestoranView());
      case RouteList.ubahKapasitasRestoran:
        return MaterialPageRoute(builder: (_)=> const KapasitasRestoranView());
      case RouteList.checkout:
        Map data = settings.arguments as Map;
        return MaterialPageRoute(builder: (_)=> PurchaseOrderView(makanan: data['makanan'],minuman: data['minuman'],orderParams: data['order'],));
      default: return null;
    }
  }
}