import 'dart:math';

import 'package:delivery_manager/presentation/bloc/auth_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCnt = TextEditingController();
  final pwdCnt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitialState) {
          if (kDebugMode) {
            print("init");
          }
          EasyLoading.show();
          context.read<AuthBloc>().add(IsAuthEvent());
        }
        if (state is AuthSiccafluid) {
          EasyLoading.showSuccess("تم تسجيل الدخول",
              duration: const Duration(seconds: 2));
          Navigator.popAndPushNamed(context, "/home");
        }
        if (state is AuthinProgressState) {
          EasyLoading.show(status: "جاري تسجيل الدخول");
        }
        if (state is LoginSuccessState) {
          EasyLoading.showSuccess("تم تسجيل الدخول",
              duration: const Duration(seconds: 2));
          Navigator.popAndPushNamed(context, "/home");
        }
      },
      child: SingleChildScrollView(
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              SizedBox(height: 10.h),
              SizedBox(
                width: 90.w,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "تسجيل الدخول الى",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        "حســـابـــك",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ]),
              ),
              SizedBox(height: 7.h),
              SizedBox(
                height: max(10.h, 60),
                width: max(90.w, 200),
                child: TextField(
                  controller: emailCnt,
                  showCursor: true,
                  enabled: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      filled: true,
                      fillColor: const Color(0x00000000),
                      suffixIcon: const Icon(Icons.email),
                      suffixIconColor: Theme.of(context).colorScheme.secondary),
                  textDirection: TextDirection.ltr,
                ),
              ),
              SizedBox(height: 3.h),
              SizedBox(
                height: max(10.h, 60),
                width: max(90.w, 200),
                child: TextField(
                  controller: pwdCnt,
                  showCursor: true,
                  enabled: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      filled: true,
                      fillColor: const Color(0x00000000),
                      suffixIcon: const Icon(Icons.lock),
                      suffixIconColor: Theme.of(context).colorScheme.secondary),
                  textDirection: TextDirection.ltr,
                ),
              ),
              SizedBox(height: 3.h),
              TextButton(
                  onPressed: () => {
                        context.read<AuthBloc>().add(
                            LoginEvent(email: emailCnt.text, pwd: pwdCnt.text))
                      },
                  child: Container(
                    width: 80.w,
                    padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      "تسجيل الدخول",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
