import 'package:barcode_widget/barcode_widget.dart';
import 'package:delivery_manager/models/package_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class PackageDetailsPage extends StatefulWidget {
  const PackageDetailsPage({super.key, required this.packageData});
  final PackageModel packageData;
  @override
  State<PackageDetailsPage> createState() => _PackageDetailsPageState();
}

class _PackageDetailsPageState extends State<PackageDetailsPage> {
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
    final data = widget.packageData;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(right: 2.w, left: 2.w),
            width: 100.w,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 2.h),
              Center(
                child: RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.headline4,
                        children: [
                      const TextSpan(text: "حالـة الطـرد: "),
                      _packageStateText(data.statePackage)
                    ])),
              ),
              SizedBox(height: 2.h),
              Center(
                child: BarcodeWidget(
                    data:
                        'This is a simple QR code dsd  flsf  fsa faff qffqfqfq ',
                    barcode: Barcode.qrCode(),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: Theme.of(context).colorScheme.primary)),
                    width: 160,
                    height: 160,
                    padding: const EdgeInsets.all(6)),
              ),
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
              SizedBox(height: 2.h),
              _printText("رقـم الهـاتـف: ", data.phoneNumber),
              SizedBox(height: 1.h),
              _printText("البـلديـة: ", data.getCityText()),
              SizedBox(height: 1.h),
              _printText("العنـوان: ", data.address ?? data.city.toString()),
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
                  )),
              SizedBox(height: 2.h),
              _printText("مبـلغ الطرد الغـيـر مدفـوعة: ",
                  data.moneyPackage.toString()),
              SizedBox(height: 2.h),
              _printText("رسوم التوصيل الغير مدفـوعة: ",
                  data.moneyDelivring.toString()),
              SizedBox(height: 2.h),
              _printText("المبـلغ الكلـي الغير مدفـوعة: ",
                  (data.moneyPackage + data.moneyDelivring).toString()),
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
                  )),
              SizedBox(height: 2.h),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.only(left: (50.w - 85), right: 50.w - 85)),
                  child: Text(
                    "استـلمة الاموال",
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
              ),
              SizedBox(height: 2.h),
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
                      padding:
                          EdgeInsets.only(left: (50.w - 78), right: 50.w - 78)),
                  child: Text(
                    "حذف الطـرد",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
