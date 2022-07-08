import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

Widget wPayPage(BuildContext context) {
  return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
    SizedBox(height: 1.h),
    Text(
      "الدفـع",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline2,
    ),
    SizedBox(
      height: 70.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 90.w,
            child: TextField(
                showCursor: true,
                enabled: true,
                decoration: InputDecoration(
                  label: Text("رقـم الهـاتـف :",
                      style: Theme.of(context).textTheme.headline4),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: const Color(0x00000000),
                )),
          ),
          SizedBox(height: 2.h),
          SizedBox(
            width: 80.w,
            child: ElevatedButton(
              child: Text("عـرض",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.white)),
              onPressed: () {},
            ),
          ),
          SizedBox(height: 2.h),
          SizedBox(
            width: 80.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary),
              child: Text(
                "الكـل",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/paying");
              },
            ),
          ),
        ],
      ),
    ),
  ]);
}
