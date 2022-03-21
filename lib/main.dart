import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';
import 'package:kopiek_resto/presentation/routes.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_screen.dart';
import 'package:kopiek_resto/presentation/views/login_view.dart';
import 'package:kopiek_resto/di/get_it.dart' as di;
import 'package:kopiek_resto/presentation/views/splash_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  await di.init();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  OneSignal.shared.setAppId('a19dec84-14c8-40ca-ae1a-d700f29908a8');

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late LoadingBloc _loadingBloc;

  @override
  void initState() {
    super.initState();
    _loadingBloc = di.di<LoadingBloc>();
  }

  @override
  void dispose() {
    _loadingBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoadingBloc>.value(
      value: _loadingBloc,
      child: ScreenUtilInit(
        designSize: const Size(375, 667),
        builder:()=> MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Kopiek Resto',
          theme: ThemeData(
              primaryColor: AppColor.primary,
              textTheme: GoogleFonts.poppinsTextTheme(),
            appBarTheme: const AppBarTheme(
              color: AppColor.primary
            )
          ),
          builder: EasyLoading.init(
            builder: (context,child){
              return LoadingScreen(screen: child!);
            }
          ),
          onGenerateRoute: AppRouter().onGenerateRoute,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
