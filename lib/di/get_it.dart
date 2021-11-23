import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/core/api_client.dart';
import 'get_it.config.dart';

final di = GetIt.I;
@InjectableInit(
  initializerName: r'$initDi',
  preferRelativeImports: true,
  asExtension: false
)

Future init() async {
  di.registerLazySingleton<Dio>(() => Dio(BaseOptions(
    connectTimeout: 20000,
    receiveTimeout: 20000,
    contentType: "application/json;charset=utf-8",
  )));
  di.registerLazySingleton<ApiClient>(() => ApiClient(dio: di()));
  $initDi(di);
}
// void injectDataSource() {
//   di.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(di()));
// }
//
//
// void injectRepository() {
//   di.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(di()));
//
// }
//
// void injectBloc() {
//   di.registerFactory(() => LoadingBloc());
//   di.registerFactory(() => AuthBloc(di()));
// }
//
// void injectUseCase() {
//   //use case
//   di.registerLazySingleton(() => Login(di()));
// }