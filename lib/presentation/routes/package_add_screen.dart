import 'dart:math';

import 'package:delivery_manager/models/anoun_client_model.dart';
import 'package:delivery_manager/models/package_model.dart';
import 'package:delivery_manager/presentation/bloc/package_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackageAddPage extends StatefulWidget {
  const PackageAddPage({Key? key}) : super(key: key);

  @override
  State<PackageAddPage> createState() => _PackageAddPageState();
}

enum FuildEnum<int> {
  senderPhone,
  senderName,
  phone,
  address,
  packagePrice,
  deliveryPrice
}

class _PackageAddPageState extends State<PackageAddPage> {
  String wilaya = WilayaEnum.BISKRA.name;
  String bladia = CityEnum.values[0].name;
  int depri = 100;
  bool dafaa = false;
  bool dafaaTawsil = true;
  List<TextEditingController> controller = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(text: "0")
  ];

  @override
  Widget build(BuildContext context) {
    WilayaEnum twilaya =
        WilayaEnum.values.firstWhere((element) => element.name == wilaya);
    CityEnum tcity =
        CityEnum.values.firstWhere((element) => element.name == bladia);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check, color: Theme.of(context).colorScheme.primary),
        onPressed: () {
          final tpack = PackageModel(
              id: 0,
              phoneNumber: controller[FuildEnum.phone.index].text,
              fullName: controller[FuildEnum.senderName.index].text,
              wilaya: twilaya,
              city: tcity,
              address: controller[FuildEnum.address.index].text,
              moneyDelivring:
                  int.parse(controller[FuildEnum.deliveryPrice.index].text),
              moneyPackage:
                  int.tryParse(controller[FuildEnum.packagePrice.index].text) ??
                      0,
              stateMoney: dafaa ? StatsMoneyEnum.RECIVER : StatsMoneyEnum.PAYED,
              stateMoneyDelivring: dafaaTawsil
                  ? StatsMoneyDeliveringEnum.RECIVER
                  : StatsMoneyDeliveringEnum.CLIENT,
              statePackage: StatePackageEnum.RECEIVING);

          final tacoount = AnounClientModel(
              name: "a", //controller[FuildEnum.senderName.index].text,
              phone: controller[FuildEnum.senderPhone.index].text);
          context.read<PackageBloc>().add(
              AddPackageEvent(anounClientModel: tacoount, packageModel: tpack));
        },
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: BlocListener<PackageBloc, PackageState>(
          listener: (context, state) {
            if (state is InProgressState) {
              EasyLoading.show(status: state.massage);
            }
            if (state is AddedPackageSucceedState) {
              EasyLoading.showSuccess("تم اضافة الطرد",
                  duration: const Duration(seconds: 2));
              Navigator.popAndPushNamed(context, '/details',
                  arguments: state.idPack);
            }
          },
          child: Column(children: [
            //AppBar
            Container(
              width: 100.w,
              height: max(7.h, 25),
              padding: EdgeInsets.only(left: 1.w),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).colorScheme.secondary,
                        blurRadius: 1.0,
                        offset: const Offset(0, 2))
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(
                    "اضـافـة طـرد",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Icon(
                    Icons.arrow_back,
                    textDirection: TextDirection.ltr,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ), //Body
            Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 3.h),
                      TextField(
                          controller: controller[FuildEnum.senderPhone.index],
                          showCursor: true,
                          enabled: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: Text("رقـم الهـاتـف المرسل :",
                                style: Theme.of(context).textTheme.headline4),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            filled: true,
                            fillColor: const Color(0x00000000),
                          )),
                      SizedBox(height: 3.h),
                      TextField(
                          controller: controller[FuildEnum.senderName.index],
                          showCursor: true,
                          enabled: true,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            label: Text("اسم المرسل : ",
                                style: Theme.of(context).textTheme.headline4),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            filled: true,
                            fillColor: const Color(0x00000000),
                          )),
                      SizedBox(height: 3.h),
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
                      SizedBox(height: 3.h),
                      TextField(
                          controller: controller[FuildEnum.phone.index],
                          showCursor: true,
                          enabled: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: Text("رقـم الهـاتـف المستـلم :",
                                style: Theme.of(context).textTheme.headline4),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            filled: true,
                            fillColor: const Color(0x00000000),
                          )),
                      SizedBox(height: 2.h),
                      Row(children: [
                        Text("الولايـة :    ",
                            style: Theme.of(context).textTheme.headline4),
                        DropdownButton<String>(
                            value: wilaya,
                            items: generateWilayaDropDownItems(context),
                            onChanged: (item) {
                              setState(() {
                                bladia = item!;
                                wilaya = item;
                              });
                            })
                      ]),
                      SizedBox(height: 2.h),
                      Row(children: [
                        Text("البـلديـة :    ",
                            style: Theme.of(context).textTheme.headline4),
                        DropdownButton<String>(
                            value: bladia,
                            items: generateCityDropDownItems(context, wilaya),
                            onChanged: (item) {
                              setState(() {
                                bladia = item!;
                              });
                            })
                      ]),
                      SizedBox(height: 3.h),
                      TextField(
                          controller: controller[FuildEnum.address.index],
                          showCursor: true,
                          enabled: true,
                          decoration: InputDecoration(
                            label: Text("العنـوان (اختياري) :",
                                style: Theme.of(context).textTheme.headline4),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            filled: true,
                            fillColor: const Color(0x00000000),
                          )),
                      SizedBox(height: 2.h),
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
                      SizedBox(height: 1.h),
                      Row(children: [
                        Text("الدفــع عند التسليــم : ",
                            style: Theme.of(context).textTheme.headline4),
                        Checkbox(
                            value: dafaa,
                            onChanged: (value) {
                              setState(() {
                                controller[FuildEnum.packagePrice.index].text =
                                    "0";
                                dafaa = value!;
                              });
                            })
                      ]),
                      if (dafaa)
                        TextField(
                            onChanged: (_) => setState(() {}),
                            controller:
                                controller[FuildEnum.packagePrice.index],
                            showCursor: true,
                            enabled: true,
                            textDirection: TextDirection.ltr,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: Text("مبلـغ الطـرد:",
                                  style: Theme.of(context).textTheme.headline4),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              filled: true,
                              fillColor: const Color(0x00000000),
                            )),
                      Row(children: [
                        Text("رسوم التوصيل عند التسليــم : ",
                            style: Theme.of(context).textTheme.headline4),
                        Checkbox(
                            value: dafaaTawsil,
                            onChanged: (value) {
                              setState(() {
                                dafaaTawsil = value!;
                              });
                            })
                      ]),
                      TextField(
                          controller: controller[FuildEnum.deliveryPrice.index],
                          onChanged: (_) => setState(() {}),
                          showCursor: true,
                          enabled: true,
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: Text("مبلـغ التـوصيـل:",
                                style: Theme.of(context).textTheme.headline4),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            filled: true,
                            fillColor: const Color(0x00000000),
                          )),
                      SizedBox(height: 2.h),
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
                      SizedBox(height: 1.h),
                      Text("المبلغ قبـل التـوصيـل : ",
                          style: Theme.of(context).textTheme.headline4),
                      SizedBox(height: 1.h),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.bodyText1,
                              children: [
                            const TextSpan(text: "رسوم التوصيل : "),
                            TextSpan(
                                text:
                                    "${!dafaaTawsil ? controller[FuildEnum.deliveryPrice.index].text : 0}DA",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary))
                          ])),
                      SizedBox(height: 2.h),
                      Text("المبلغ عند التـوصيـل : ",
                          style: Theme.of(context).textTheme.headline4),
                      SizedBox(height: 1.h),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.bodyText1,
                              children: [
                            const TextSpan(text: "مبـلغ الطـرد : "),
                            TextSpan(
                                text:
                                    "${dafaa ? controller[FuildEnum.packagePrice.index].text : 0}DA",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary))
                          ])),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.bodyText1,
                              children: [
                            const TextSpan(text: "رسوم التوصيل : "),
                            TextSpan(
                                text:
                                    "${dafaaTawsil ? controller[FuildEnum.deliveryPrice.index].text : 0}DA",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary))
                          ])),
                      SizedBox(height: 2.h),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(fontSize: 25),
                              children: [
                            const TextSpan(text: "المجـموع : "),
                            TextSpan(
                                text:
                                    "${((int.tryParse(controller[FuildEnum.deliveryPrice.index].text) ?? 0) + (dafaa ? int.tryParse(controller[FuildEnum.packagePrice.index].text) ?? 0 : 0))}DA",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary))
                          ])),
                    ]))
          ]),
        ),
      )),
    );
  }
}

List<DropdownMenuItem<String>> generateCityDropDownItems(
    BuildContext context, String pwilaya) {
  List<List<Object>> tmpBladia = [];
  final wilaya =
      WilayaEnum.values.firstWhere((element) => element.name == pwilaya);
  if (wilaya == WilayaEnum.BISKRA) tmpBladia = bladiaList;
  if (wilaya == WilayaEnum.BATNA) tmpBladia = bladiaBatnaList;
  if (wilaya == WilayaEnum.OuledDjellal) tmpBladia = bladiaOuladJilal;

  return List.generate(
      tmpBladia.length,
      (index) => DropdownMenuItem(
          value: (tmpBladia[index][0] as CityEnum).name,
          child: SizedBox(
            width: 50.w,
            child: Text(tmpBladia[index][1] as String,
                style: Theme.of(context).textTheme.headline2),
          )));
}

List<DropdownMenuItem<String>> generateWilayaDropDownItems(
    BuildContext context) {
  return List.generate(wilayaList.length, (index) {
    return DropdownMenuItem(
        value: (wilayaList[index][0] as WilayaEnum).name,
        child: SizedBox(
          width: 50.w,
          child: Text(wilayaList[index][1] as String,
              style: Theme.of(context).textTheme.headline2),
        ));
  });
}
