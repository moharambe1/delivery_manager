import 'package:delivery_manager/models/package_model.dart';
import 'package:delivery_manager/models/package_select_model.dart';
import 'package:delivery_manager/presentation/bloc/user_data_bloc.dart';
import 'package:delivery_manager/presentation/cubit/paying_mony_cubit.dart';
import 'package:delivery_manager/presentation/widget/w_package_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class PayingPage extends StatefulWidget {
  const PayingPage(
      {super.key,
      required this.phone,
      required this.statePackage,
      required this.onCheck,
      this.all = false});
  final String phone;
  final StatePackageEnum statePackage;
  final bool all;
  final void Function(BuildContext, PackageSelectModel, bool?) onCheck;
  @override
  State<PayingPage> createState() => _PayingPageState();
}

class _PayingPageState extends State<PayingPage> {
  Widget _infoPrint(BuildContext context, String name) {
    return Container(
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
              widget.phone,
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
    final fnOnCheck = widget.onCheck;

    context.read<PayingMonyCubit>().clear();
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => UserDataBloc(),
          child: BlocBuilder<UserDataBloc, UserDataState>(
            builder: (context, state) {
              if (state is UserDataLeadingState) {
                return const Center(child: Text(" جـاري التـحميـل"));
              }
              if (state is UserDataLeadedState) {
                context.read<PayingMonyCubit>().clear();
                return SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _infoPrint(context, state.name),
                        SizedBox(height: 1.h),
                        SizedBox(
                          height: 78.h - 86,
                          child: SingleChildScrollView(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                                state.packages.length,
                                (index) => Container(
                                    padding: EdgeInsets.only(bottom: 1.h),
                                    child: WPackageSleact(
                                        packageSelectModel:
                                            state.packages[index],
                                        onChange: fnOnCheck))),
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
                                for (PackageSelectModel element
                                    in state.packages) {
                                  if (element.isSelect) {
                                    ids.add(element.packageData.id!);
                                  }
                                }
                                context.read<UserDataBloc>().add(
                                    ChangeUserPackagesStateEvent(
                                        statePackage: StatePackageEnum.DONE,
                                        packSels: state.packages));
                              },
                            )),
                        SizedBox(height: 1.h)
                      ]),
                );
              }
              if (state is UserDataInitial) {
                if (!widget.all) {
                  context.read<UserDataBloc>().add(GetUserPackageForUserEvent(
                      phone: widget.phone, statePackage: widget.statePackage));
                } else if (widget.all) {
                  context
                      .read<UserDataBloc>()
                      .add(GetAllUserPackagsEvent(state: widget.statePackage));
                }
                return Container();
              }
              return const Center(child: Text("حصل خطأ"));
            },
          ),
        ),
      ),
    );
  }
}
