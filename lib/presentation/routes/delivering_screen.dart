import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'package:delivery_manager/presentation/routes/home_screen.dart';
import 'package:delivery_manager/presentation/widget/w_package_card.dart';

enum IconPath { package, delivering, success, faild }

class BtnTextData {
  String text;
  void Function() onPressed;
  BtnTextData({
    required this.text,
    required this.onPressed,
  });
}

final topBtn = [
  BtnTextData(text: "جاري التوصيل", onPressed: () {}),
  BtnTextData(text: "تم التوصيل", onPressed: () {}),
  BtnTextData(text: "فشل التوصيل", onPressed: () {}),
];

class DeliveringPage extends StatefulWidget {
  const DeliveringPage({super.key});

  @override
  State<DeliveringPage> createState() => _DeliveringPageState();
}

class _DeliveringPageState extends State<DeliveringPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Center(
      child: SizedBox(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BackButton(),
              Text(
                "العمال",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              BackButton(
                color: Colors.transparent,
                onPressed: () {},
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 4),
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                boxShadow: const [
                  BoxShadow(blurRadius: 2, offset: Offset(0, 2))
                ]),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(topBtn.length, (index) {
                return Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: btnText(context, topBtn[index]));
              })),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(15, (index) {
              return Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: packageCard(context, tPackages[index % 2], 70, 90.w));
            }),
          ),
        ],
      )),
    ))));
  }
}

Widget btnText(BuildContext context, BtnTextData data) {
  return ElevatedButton(
      onPressed: data.onPressed,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(data.text, style: Theme.of(context).textTheme.bodyText1),
      ));
}
