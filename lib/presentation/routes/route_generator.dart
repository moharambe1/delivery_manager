import 'package:delivery_manager/models/package_model.dart';
import 'package:delivery_manager/presentation/routes/delivering_screen.dart';
import 'package:delivery_manager/presentation/routes/home_screen.dart';
import 'package:delivery_manager/presentation/routes/package_add_screen.dart';
import 'package:delivery_manager/presentation/routes/package_details.dart';
import 'package:delivery_manager/presentation/routes/paying_screen.dart';
import 'package:flutter/material.dart';
import 'package:delivery_manager/presentation/routes/login_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case '/':
        {
          return MaterialPageRoute(
              builder: (_) => const Directionality(
                  textDirection: TextDirection.rtl, child: LoginPage()));
        }
      case '/login':
        {
          return MaterialPageRoute(
              builder: (_) => const Directionality(
                  textDirection: TextDirection.rtl, child: LoginPage()));
        }
      case '/home':
        {
          return MaterialPageRoute(
              builder: (_) => const Directionality(
                  textDirection: (TextDirection.rtl), child: HomePage()));
        }

      case '/details':
        {
          return MaterialPageRoute(
              builder: (_) => const Directionality(
                  textDirection: (TextDirection.rtl),
                  child: PackageDetailsPage(
                      packageData: PackageModel(
                          id: 1,
                          fullName: "ahmed",
                          phoneNumber: "0771000000",
                          statePackage: StatePackageEnum.RECEIVED,
                          stateMoney: StatsMoneyEnum.CLIENT,
                          stateMoneyDelivring: StatsMoneyDeliveringEnum.CLIENT,
                          address: "حي الحوزة",
                          moneyDelivring: 1000))));
        }
      case '/addPackage':
        {
          return MaterialPageRoute(
              builder: (_) => const Directionality(
                  textDirection: (TextDirection.rtl), child: PackageAddPage()));
        }
      case '/paying':
        {
          return MaterialPageRoute(
              builder: (_) => const Directionality(
                  textDirection: (TextDirection.rtl), child: PayingPage()));
        }
      case '/delivering':
        {
          return MaterialPageRoute(
              builder: (_) => const Directionality(
                  textDirection: (TextDirection.rtl), child: DeliveringPage()));
        }

      default:
        {
          return throw ErrorDescription("Route doesn't find ");
        }
    }
  }
}
