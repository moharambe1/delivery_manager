import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

Widget wDeliverPage(BuildContext context) {
  return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
    SizedBox(height: 1.h),
    Text(
      "العمال",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline2,
    ),
    SizedBox(
      height: 70.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              width: 90.w,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2, color: Theme.of(context).colorScheme.primary),
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15)),
              alignment: Alignment.center,
              child: DropdownButton(
                elevation: 4,
                iconSize: 32,
                items: [
                  DropdownMenuItem(
                    child: SizedBox(
                        width: 88.w - 50,
                        child: Text(
                          textDirection: TextDirection.rtl,
                          "محمد",
                          style: Theme.of(context).textTheme.headline2,
                        )),
                  )
                ],
                onChanged: (value) {},
              )),
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
        ],
      ),
    ),
  ]);
}
