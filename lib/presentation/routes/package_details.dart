import 'package:barcode_widget/barcode_widget.dart';
import 'package:delivery_manager/models/package_model.dart';
import 'package:delivery_manager/presentation/bloc/package_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:tuple/tuple.dart';

class PackageDetailsPage extends StatefulWidget {
  const PackageDetailsPage({super.key, required this.id});
  final int id;
  @override
  State<PackageDetailsPage> createState() => _PackageDetailsPageState();
}

class _PackageDetailsPageState extends State<PackageDetailsPage> {
  void _helperChangeState(
      BuildContext context, int id, StatePackageEnum newState) {
    context
        .read<PackageDetailsBloc>()
        .add(ChangePackageStateEvent(id: id, newState: newState));
  }

  Widget _btnChangeState(BuildContext context, PackageModel pack) {
    // if (pack.statePackage == StatePackageEnum.DONE) return const SizedBox();
    final mapBtn = <StatePackageEnum, List<dynamic>>{
      StatePackageEnum.RECEIVING: [
        [
          "استـلمة الطرد",
          () => _helperChangeState(context, pack.id!, StatePackageEnum.STORED)
        ]
      ],
      StatePackageEnum.RECEIVED: [
        [
          "أستـلمة الطرد",
          () => _helperChangeState(context, pack.id!, StatePackageEnum.STORED)
        ]
      ],
      StatePackageEnum.STORED: [
        [
          "استـلمة الاموال",
          () => _helperChangeState(context, pack.id!, StatePackageEnum.PAYED)
        ],
        [
          "فـشل التـوصيـل",
          () => _helperChangeState(context, pack.id!, StatePackageEnum.RETURN)
        ]
      ],
      StatePackageEnum.DELEVERED: [
        [
          "استـلمة الاموال",
          () => _helperChangeState(context, pack.id!, StatePackageEnum.PAYED)
        ]
      ],
      StatePackageEnum.RETURNING: [
        [
          "أستـلمة الطرد",
          () => _helperChangeState(context, pack.id!, StatePackageEnum.RETURN)
        ]
      ],
      StatePackageEnum.PAYED: [
        [
          "تـم الدفـع",
          () => _helperChangeState(context, pack.id!, StatePackageEnum.DONE)
        ]
      ],
      StatePackageEnum.RETURN: [
        [
          "تـم ارجـاع الطرد",
          () => _helperChangeState(context, pack.id!, StatePackageEnum.DONE)
        ]
      ]
    };

    final lData = mapBtn[pack.statePackage] ?? [];

    return Column(
      children: List.generate(
        lData.length,
        (index) {
          return Container(
            width: 88.w,
            padding: EdgeInsets.only(bottom: 2.h),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: lData[index][1],
                child: Center(
                    child: Text(
                  lData[index][0],
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.white),
                ))),
          );
        },
      ),
    );
  }

  Widget _printText(String title, String text) {
    return RichText(
        text: TextSpan(style: Theme.of(context).textTheme.headline4, children: [
      TextSpan(text: title),
      TextSpan(
          text: text,
          style: TextStyle(color: Theme.of(context).colorScheme.primary))
    ]));
  }

  TextSpan _packageStateText(StatePackageEnum state) {
    switch (state) {
      case StatePackageEnum.DELEVERED:
        return TextSpan(
            text: "تـم التـوصيـل",
            style: Theme.of(context).textTheme.headline3);
      case StatePackageEnum.RETURN:
        return TextSpan(
            text: "قيـد الارجـاع",
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.red));
      default:
        return TextSpan(
            text: "قيد التـوصيـل",
            style: Theme.of(context).textTheme.headline3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(right: 2.w, left: 2.w),
            width: 100.w,
            child: BlocProvider(
              create: (context) => PackageDetailsBloc(),
              child: BlocBuilder<PackageDetailsBloc, PackageDetailsState>(
                builder: (context, state) {
                  if (state is PackageLoadingState) {
                    return const Center(child: Text("جـاري تـحميـل "));
                  }
                  if (state is PackageLoadedState) {
                    final data = state.package;
                    final packageMonyDontPayed = data.packageMonyDontPayed;
                    final delivringMoneyDontPayed = data.delivringMonyDontPayed;
                    final allMonyDontPayed =
                        packageMonyDontPayed + delivringMoneyDontPayed;
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.h),
                          Center(
                            child: RichText(
                                text: TextSpan(
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                    children: [
                                  const TextSpan(text: "حالـة الطـرد: "),
                                  _packageStateText(data.statePackage)
                                ])),
                          ),
                          SizedBox(height: 2.h),
                          Center(
                            child: BarcodeWidget(
                                data: {'package': data.toMap().toString()}
                                    .toString(),
                                barcode: Barcode.qrCode(),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                                width: 160,
                                height: 160,
                                padding: const EdgeInsets.all(6)),
                          ),
                          Center(
                            child: Container(
                                width: 95.w,
                                margin: EdgeInsets.only(top: 3.h, bottom: 2.h),
                                child: Divider(
                                    thickness: 2,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                          ),
                          SizedBox(height: 2.h),
                          _printText("رقـم هـاتـف المرسل: ", state.phone),
                          SizedBox(height: 2.h),
                          _printText("اسم المرسل: ", data.fullName ?? "مجـهول"),
                          Center(
                            child: Container(
                                width: 95.w,
                                margin: EdgeInsets.only(top: 3.h, bottom: 2.h),
                                child: Divider(
                                    thickness: 2,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                          ),
                          SizedBox(height: 2.h),
                          _printText("رقـم الهـاتـف: ", data.phoneNumber),
                          SizedBox(height: 1.h),
                          _printText("الولايـة: ", data.getWilayaText()),
                          SizedBox(height: 1.h),
                          _printText("البـلديـة: ", data.getCityText()),
                          SizedBox(height: 1.h),
                          _printText("العنـوان: ", data.address ?? "مجـهول"),
                          Center(
                            child: Container(
                                width: 95.w,
                                margin: EdgeInsets.only(top: 2.h, bottom: 2.h),
                                child: Divider(
                                    thickness: 2,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                          ),
                          _printText(
                              "مبـلغ الطردع: ", data.moneyPackage.toString()),
                          SizedBox(height: 2.h),
                          _printText("رسوم التوصيل : ",
                              data.moneyDelivring.toString()),
                          SizedBox(height: 2.h),
                          _printText(
                              "المبـلغ الكلـي : ",
                              (data.moneyDelivring + data.moneyPackage)
                                  .toString()),
                          Center(
                            child: Container(
                                width: 95.w,
                                margin: EdgeInsets.only(top: 2.h, bottom: 2.h),
                                child: Divider(
                                    thickness: 2,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                          ),
                          _printText("مبـلغ الطرد الغـير مدفـوعة: ",
                              packageMonyDontPayed.toString()),
                          SizedBox(height: 2.h),
                          _printText("رسوم التوصيل الغير مدفـوعة: ",
                              delivringMoneyDontPayed.toString()),
                          SizedBox(height: 2.h),
                          _printText("المبـلغ الكلـي الغير مدفـوعة: ",
                              allMonyDontPayed.toString()),
                          Center(
                            child: Container(
                                width: 95.w,
                                margin: EdgeInsets.only(top: 5.h, bottom: 2.h),
                                child: Divider(
                                    thickness: 2,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                          ),
                          Center(child: _btnChangeState(context, data)),
                          Center(
                            child: Container(
                                width: 95.w,
                                margin: EdgeInsets.only(top: 3.h, bottom: 2.h),
                                child: Divider(
                                    thickness: 2,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                          ),
                          /*  SizedBox(height: 2.h),
                                          Center(
                                            child: SizedBox(
                                              width: 88.w,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(),
                                                child: Center(
                                                  child: Text(
                                                    "استـلمة الاموال",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2!
                                                        .copyWith(color: Colors.white),
                                                  ),
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 2.h),
                                          Center(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.orange,
                                                  padding:
                                                      EdgeInsets.only(left: (50.w - 80), right: 50.w - 80)),
                                              child: Text(
                                                "استـلمة الطرد",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2!
                                                    .copyWith(color: Colors.white),
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          Container(
                                            height: 2.h,
                                            width: 95.w,
                                            alignment: Alignment.center,
                                            child: Divider(
                                              indent: 20,
                                              endIndent: 20,
                                              thickness: 2,
                                              color: Theme.of(context).colorScheme.secondary,
                                            ),
                                          ),
                                          SizedBox(height: 2.h),
                                          Center(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding:
                                                      EdgeInsets.only(left: (50.w - 95), right: 50.w - 95)),
                                              child: Text(
                                                "تـم ارجاع الاموال",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2!
                                                    .copyWith(color: Colors.white),
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                          SizedBox(height: 2.h),
                                          Center(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.orange,
                                                  padding:
                                                      EdgeInsets.only(left: (50.w - 90), right: 50.w - 90)),
                                              child: Text(
                                                "تـم ارجاع الطرد",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2!
                                                    .copyWith(color: Colors.white),
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          Container(
                                            height: 2.h,
                                            width: 95.w,
                                            alignment: Alignment.center,
                                            child: Divider(
                                              indent: 20,
                                              endIndent: 20,
                                              thickness: 2,
                                              color: Theme.of(context).colorScheme.secondary,
                                            ),
                                          ),*/

                          SizedBox(height: 2.h),
                          Center(
                            child: Container(
                              width: 88.w,
                              padding: EdgeInsets.only(bottom: 2.h),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(),
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/printing",
                                        arguments:
                                            Tuple2(state.phone, state.package));
                                  },
                                  child: Center(
                                      child: Text(
                                    "طبـاعة",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(color: Colors.white),
                                  ))),
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.only(
                                      left: (50.w - 100), right: 50.w - 100)),
                              child: Text(
                                "تـعديـل المعلومات",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: Colors.white),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    padding: EdgeInsets.only(
                                        left: (50.w - 78), right: 50.w - 78)),
                                child: Text(
                                  "حذف الطـرد",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(color: Colors.white),
                                ),
                                onPressed: () {}),
                          ),
                          SizedBox(height: 2.h),
                        ]);
                  }
                  if (state is PackageDetailsInitial) {
                    context
                        .read<PackageDetailsBloc>()
                        .add(GetPackageDetailsEvent(id: widget.id));
                    return const Text("inits");
                  } else {
                    /*context
                                  .read<PackageDetailsBloc>()
                                  .add(GetPackageDetailsEvent(id: widget.packageData.id!));*/
                    return Container(
                        alignment: Alignment.center,
                        child: const Text("لايـوجد طرد بـهذا الرقـم"));
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
