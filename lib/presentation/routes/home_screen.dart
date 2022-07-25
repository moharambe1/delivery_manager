import 'package:delivery_manager/models/package_model.dart';
import 'package:delivery_manager/presentation/cubit/home_navbar_cubit.dart';
import 'package:delivery_manager/presentation/widget/home/w_delivery.dart';
import 'package:delivery_manager/presentation/widget/home/w_paying.dart';
import 'package:delivery_manager/presentation/widget/home/w_store.dart';
import 'package:delivery_manager/presentation/widget/w_button_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

const navigationBarItem = [
  ["assets/icons/icon_deliver_failed.png", "فشل توصيل"],
  ["assets/icons/icon_deliver_success.png", "تم توصيل"],
  ["assets/icons/icon_deliver_delivering.png", "في الطريق"],
  ["assets/icons/icon_deliver_packages.png", "المستودع"],
];
List<PackageModel> tPackages = const [
  PackageModel(
      id: 1,
      fullName: "ahmed",
      phoneNumber: "0771000000",
      statePackage: StatePackageEnum.RECEIVED,
      stateMoney: StatsMoneyEnum.CLIENT,
      stateMoneyDelivring: StatsMoneyDeliveringEnum.CLIENT,
      address: "حي الحوزة",
      moneyDelivring: 1000),
  PackageModel(
      id: 2,
      fullName: "achraf",
      phoneNumber: "0771000000",
      statePackage: StatePackageEnum.DELEVERED,
      stateMoney: StatsMoneyEnum.CLIENT,
      stateMoneyDelivring: StatsMoneyDeliveringEnum.CLIENT,
      address: "حي البخاري",
      moneyDelivring: 10000)
];

class _HomePageState extends State<HomePage> {
  int indexSlecte = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
          child: Stack(
            children: [
              Positioned(
                left: 5,
                bottom: 60,
                child: FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: () => {Navigator.pushNamed(context, "/scaning")},
                    child: Container(
                        padding: const EdgeInsets.all(4),
                        alignment: Alignment.center,
                        child: Container(
                            padding: const EdgeInsets.all(1),
                            child: Icon(
                              Icons.qr_code_scanner,
                              color: Theme.of(context).colorScheme.primary,
                              size: 40,
                            )))),
              ),
              Positioned(
                left: 5,
                bottom: 0,
                child: FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: () =>
                        {Navigator.pushNamed(context, "/addPackage")},
                    child: Container(
                        padding: const EdgeInsets.all(4),
                        alignment: Alignment.center,
                        child: Container(
                            padding: const EdgeInsets.all(1),
                            child: Image.asset(
                              "assets/icons/icon_deliver_add.png",
                            )))),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        bottomNavigationBar: const WButtomNavBar(),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Center(
          child: SizedBox(
              width: 99.w,
              child: BlocBuilder<HomeNavbarCubit, HomeNavBarEnum>(
                builder: (context, state) {
                  if (state == HomeNavBarEnum.home) {
                    return wStorePage(context);
                  }
                  if (state == HomeNavBarEnum.paying) {
                    return wPayPage(context, StatePackageEnum.PAYED, 'الـدفـع');
                  }
                  if (state == HomeNavBarEnum.returning) {
                    return wPayPage(
                        context, StatePackageEnum.RETURN, 'الارجاع');
                  }
                  if (state == HomeNavBarEnum.delevring) {
                    return wDeliverPage(context);
                  } else {
                    return Container();
                  }
                },
              )),
        ))));
  }
}
