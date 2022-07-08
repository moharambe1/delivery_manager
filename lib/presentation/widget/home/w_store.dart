import 'package:delivery_manager/models/package_model.dart';
import 'package:delivery_manager/presentation/bloc/store_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

Widget wStorePage(BuildContext context) {
  final topBtn = [
    BtnTextData(
        text: "الكـل",
        onPressed: () {
          context
              .read<StorePageBloc>()
              .add(const GetPackagesEvent(state: StatePackageEnum.DELEVERED));
        }),
    BtnTextData(text: "الموستدع", onPressed: () {}),
    BtnTextData(text: "جاري التوصيل", onPressed: () {}),
    BtnTextData(text: "تم التوصيل", onPressed: () {}),
    BtnTextData(text: "فشل التوصيل", onPressed: () {}),
  ];
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.only(bottom: 10, top: 4),
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            boxShadow: const [BoxShadow(blurRadius: 2, offset: Offset(0, 2))]),
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
      BlocBuilder<StorePageBloc, StorePageState>(
        builder: (context, state) {
          if (state is PackagesStorePageState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(15, (index) {
                return Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child:
                        packageCard(context, tPackages[index % 2], 70, 90.w));
              }),
            );
          } else {
            return Container();
          }
        },
      ),
    ],
  );
}

Widget btnText(BuildContext context, BtnTextData data) {
  return ElevatedButton(
      onPressed: data.onPressed,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(data.text, style: Theme.of(context).textTheme.bodyText1),
      ));
}
