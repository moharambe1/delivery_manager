import 'package:delivery_manager/models/package_model.dart';
import 'package:delivery_manager/models/package_select_model.dart';
import 'package:delivery_manager/presentation/bloc/store_page_bloc.dart';
import 'package:delivery_manager/presentation/cubit/paying_mony_cubit.dart';
import 'package:delivery_manager/presentation/widget/w_package_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class PayingPage extends StatefulWidget {
  const PayingPage({super.key});
  final String phone = "0771000000";
  @override
  State<PayingPage> createState() => _PayingPageState();
}

List<PackageSelectModel> tPackages = [
  PackageSelectModel(
      packageData: const PackageModel(
          id: 1,
          fullName: "ahmed",
          phoneNumber: "0771000000",
          statePackage: StatePackageEnum.RECEIVED,
          stateMoney: StatsMoneyEnum.CLIENT,
          stateMoneyDelivring: StatsMoneyDeliveringEnum.CLIENT,
          moneyPackage: 100,
          address: "حي الحوزة",
          moneyDelivring: 1000),
      isSelect: false),
  PackageSelectModel(
      packageData: const PackageModel(
          id: 2,
          fullName: "achraf",
          phoneNumber: "0771000000",
          statePackage: StatePackageEnum.DELEVERED,
          stateMoney: StatsMoneyEnum.CLIENT,
          stateMoneyDelivring: StatsMoneyDeliveringEnum.CLIENT,
          moneyPackage: 10,
          address: "حي البخاري",
          moneyDelivring: 10000))
];

class _PayingPageState extends State<PayingPage> {
  Widget _infoPrint() {
    return Container(
      height: 2.h + 107,
      padding: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [BoxShadow(offset: Offset(0, 2), blurRadius: 2)]),
      child: Column(
        children: [
          Container(
            alignment: Alignment.bottomRight,
            child: const BackButton(),
          ),
          SizedBox(
            width: 90.w,
            child: Text(
              "0777777777",
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.end,
            ),
          ),
          BlocBuilder<PayingMonyCubit, int>(
            builder: (context, state) {
              return SizedBox(
                  width: 90.w,
                  child: Text(
                    ("المبلغ : $stateدج"),
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.right,
                  ));
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<PayingMonyCubit>().clear();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _infoPrint(),
                SizedBox(height: 1.h),
                SizedBox(
                  height: 78.h - 86,
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                        2,
                        (index) => Container(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: WPackageSleact(
                                packageSelectModel: tPackages[index]))),
                  )),
                ),
                SizedBox(height: 1.h),
                SizedBox(
                    height: 50,
                    width: 80.w,
                    child: ElevatedButton(
                      child: Text("دفـع",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.white)),
                      onPressed: () {
                        List<int> ids = [];
                        for (PackageSelectModel element in tPackages) {
                          if (element.isSelect) {
                            ids.add(element.packageData.id);
                          }
                        }
                        context.read<StorePageBloc>().add(
                            PayPackagesForUserEvent(
                                phone: widget.phone, ids: ids));
                      },
                    )),
                SizedBox(height: 1.h)
              ]),
        ),
      ),
    );
  }
}
