import 'package:delivery_manager/models/package_model.dart';
import 'package:delivery_manager/presentation/bloc/user_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:tuple/tuple.dart';

Widget wPayPage(
    BuildContext context, StatePackageEnum pcackState, String title) {
  final controller = TextEditingController()..text = "";
  return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
    SizedBox(height: 1.h),
    Text(
      title,
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
                textDirection: TextDirection.ltr,
                controller: controller,
                showCursor: true,
                enabled: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text("رقـم الهـاتـف :",
                      style: Theme.of(context).textTheme.headline4),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: const Color(0x00000000),
                )),
          ),
          BlocProvider(
            create: (context) => UserDataBloc(),
            child: BlocListener<UserDataBloc, UserDataState>(
              listener: (context, state) {
                if (state is UserNotFound) {
                  // EasyLoading.showError("يح لا");
                }
                if (state is UserFoundState) {
                  EasyLoading.dismiss();
                  Navigator.pushNamed(context, '/paying',
                      arguments: Tuple2<String, StatePackageEnum>(
                          controller.text, pcackState));
                }
              },
              child: BlocBuilder<UserDataBloc, UserDataState>(
                builder: (context, state) {
                  if (state is UserDataLeadingState) {
                    EasyLoading.show(status: "جـاري البـحث");
                    return Container();
                  } else {
                    return Column(
                      children: [
                        SizedBox(height: 2.h),
                        SizedBox(
                          width: 80.w,
                          child: ElevatedButton(
                              child: Text("عـرض",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(color: Colors.white)),
                              onPressed: () {
                                context.read<UserDataBloc>().add(
                                    GetUserIdEvent(phone: controller.text));
                              }),
                        ),
                        SizedBox(height: 2.h),
                        SizedBox(
                          width: 80.w,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      Theme.of(context).colorScheme.secondary),
                              child: Text(
                                "الكـل",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: Colors.white),
                              ),
                              onPressed: () {
                                EasyLoading.dismiss();
                                Navigator.pushNamed(context, '/paying',
                                    arguments: Tuple2<String, StatePackageEnum>(
                                        "", pcackState));
                              }),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    ),
  ]);
}
