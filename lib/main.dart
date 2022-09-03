import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';

import 'package:delivery_manager/inject.dart';
import 'package:delivery_manager/presentation/bloc/auth_bloc.dart';
import 'package:delivery_manager/presentation/bloc/package_bloc.dart';
import 'package:delivery_manager/presentation/bloc/store_page_bloc.dart';
import 'package:delivery_manager/presentation/cubit/home_navbar_cubit.dart';
import 'package:delivery_manager/presentation/cubit/paying_mony_cubit.dart';
import 'package:delivery_manager/presentation/provider/themes_provider.dart';
import 'package:delivery_manager/presentation/routes/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(milliseconds: 300));

  configureDependencies();
  //Directory pathStore = await getApplicationDocumentsDirectory();
  final cookieJar = CookieJar();
  final option =
      BaseOptions(baseUrl: 'http://144.24.193.202:8080', connectTimeout: 3000);

  final Dio dio = Dio(option)..interceptors.add(CookieManager(cookieJar));
  getIt.registerFactory<Dio>(() => dio);

  runApp(ChangeNotifierProvider<ThemesProvider>(
      create: (_) => ThemesProvider(darkTheme: false), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the r oot of your application.
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return FlutterSizer(builder: (context, orientation, screenType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<PackageBloc>(create: (context) => PackageBloc()),
            BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
            BlocProvider<HomeNavbarCubit>(
                create: (context) => HomeNavbarCubit()),
            BlocProvider<PayingMonyCubit>(
                create: (context) => PayingMonyCubit()),
            BlocProvider<StorePageBloc>(create: (context) => StorePageBloc()),
          ],
          child: MaterialApp(
              title: 'Flutter Demo',
              theme: context.watch<ThemesProvider>().themeData,
              initialRoute: '/login',
              debugShowCheckedModeBanner: false,
              onGenerateRoute: RouteGenerator.generateRoute,
              builder: EasyLoading.init()),
        );
      });
    });
  }
}
