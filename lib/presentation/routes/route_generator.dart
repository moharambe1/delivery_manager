import 'package:delivery_manager/models/package_model.dart';
import 'package:delivery_manager/models/package_select_model.dart';
import 'package:delivery_manager/presentation/cubit/paying_mony_cubit.dart';
import 'package:delivery_manager/presentation/routes/delivering_screen.dart';
import 'package:delivery_manager/presentation/routes/home_screen.dart';
import 'package:delivery_manager/presentation/routes/leading_screen.dart';
import 'package:delivery_manager/presentation/routes/package_add_screen.dart';
import 'package:delivery_manager/presentation/routes/package_details.dart';
import 'package:delivery_manager/presentation/routes/paying_screen.dart';
import 'package:delivery_manager/presentation/routes/print_package_screen.dart';
import 'package:delivery_manager/presentation/routes/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:delivery_manager/presentation/routes/login_screen.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static final Map<StatePackageEnum,
          void Function(BuildContext context, PackageSelectModel p1, bool? p2)>
      payOnCheck = {
    StatePackageEnum.PAYED:
        (BuildContext context, PackageSelectModel p1, bool? p2) {
      if (p1.isSelect) {
        context.read<PayingMonyCubit>().addMony(p1.packageData.moneyPackage);
      } else if (!p1.isSelect) {
        context.read<PayingMonyCubit>().addMony(-p1.packageData.moneyPackage);
      }
    },
    StatePackageEnum.RETURN:
        (BuildContext context, PackageSelectModel p1, bool? p2) {
      if (p1.packageData.stateMoneyDelivring ==
          StatsMoneyDeliveringEnum.PAYED) {
        if (p1.isSelect) {
          context
              .read<PayingMonyCubit>()
              .addMony(p1.packageData.moneyDelivring);
        } else if (!p1.isSelect) {
          context
              .read<PayingMonyCubit>()
              .addMony(-p1.packageData.moneyDelivring);
        }
      }
    },
  };
  // static bool? isloogin;
  static Route<dynamic> generateRoute(RouteSettings settings) {
    /* if (isloogin != null && isloogin == false) {

      isloogin = true;
    }*/

    // final args = settings.arguments;
    switch (settings.name) {
      case '/leading':
        {
          return MaterialPageRoute(
              builder: (_) => const Directionality(
                  textDirection: TextDirection.rtl, child: LeadingPage()));
        }
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
          final id = settings.arguments as int;
          return MaterialPageRoute(
              builder: (_) => Directionality(
                  textDirection: (TextDirection.rtl),
                  child: PackageDetailsPage(id: id)));
        }
      case '/addPackage':
        {
          return MaterialPageRoute(
              builder: (_) => const Directionality(
                  textDirection: (TextDirection.rtl), child: PackageAddPage()));
        }
      case '/paying':
        {
          final arg = settings.arguments as Tuple2<String, StatePackageEnum>;

          final onCheck = payOnCheck[arg.item2];

          if (onCheck != null) {
            if (arg.item1.isEmpty) {
              return MaterialPageRoute(
                  builder: (_) => Directionality(
                      textDirection: (TextDirection.rtl),
                      child: PayingPage(
                          phone: "الجـميـع",
                          statePackage: arg.item2,
                          onCheck: onCheck,
                          all: true)));
            }
            return MaterialPageRoute(
                builder: (_) => Directionality(
                    textDirection: (TextDirection.rtl),
                    child: PayingPage(
                        phone: arg.item1,
                        statePackage: arg.item2,
                        onCheck: onCheck)));
          }
          return throw ErrorDescription("statePackage onCheck doesn't find ");
        }
      //case '/returing':

      case '/delivering':
        {
          return MaterialPageRoute(
              builder: (_) => const Directionality(
                  textDirection: (TextDirection.rtl), child: DeliveringPage()));
        }
      case "/scaning":
        {
          return MaterialPageRoute(
              builder: (_) => const Directionality(
                  textDirection: (TextDirection.rtl), child: ScanPage()));
        }
      case '/printing':
        {
          /*PackageModel(
                          id: 1,
                          fullName: "ahmed",
                          phoneNumber: "0771000000",
                          statePackage: StatePackageEnum.RECEIVED,
                          stateMoney: StatsMoneyEnum.CLIENT,
                          stateMoneyDelivring: StatsMoneyDeliveringEnum.CLIENT,
                          address: "حي الحوزة",
                          moneyDelivring: 1000)*/
          final arg = settings.arguments as Tuple2<String, PackageModel>?;
          if (arg != null) {
            return MaterialPageRoute(
                builder: (_) => Directionality(
                    textDirection: (TextDirection.rtl),
                    child: PringPackagePage(
                        senderPhone: arg.item1, data: arg.item2)));
          }
          return throw ErrorDescription("Route doesn't find ");
        }
      default:
        {
          return throw ErrorDescription("Route doesn't find ");
        }
    }
  }
}
