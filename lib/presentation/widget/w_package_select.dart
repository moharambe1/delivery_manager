import 'package:delivery_manager/models/package_select_model.dart';
import 'package:delivery_manager/presentation/cubit/paying_mony_cubit.dart';
import 'package:delivery_manager/presentation/widget/w_package_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class WPackageSleact extends StatefulWidget {
  const WPackageSleact({super.key, required this.packageSelectModel});
  final PackageSelectModel packageSelectModel;
  @override
  State<WPackageSleact> createState() => _WPackageSleactState();
}

class _WPackageSleactState extends State<WPackageSleact> {
  bool bselect = false;

  @override
  Widget build(BuildContext context, {void Function(bool?)? onChange}) {
    return Container(
      width: 99.w,
      padding: EdgeInsets.only(right: 1.w),
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          packageCard(
              context, widget.packageSelectModel.packageData, 70, 90.w - 50,
              shadow: false),
          Checkbox(
              value: bselect,
              onChanged: (value) {
                onChange ?? (value);
                widget.packageSelectModel.isSelect = value!;
                if (widget.packageSelectModel.isSelect) {
                  context.read<PayingMonyCubit>().addMony(
                      widget.packageSelectModel.packageData.moneyPackage);
                }
                if (!widget.packageSelectModel.isSelect) {
                  context.read<PayingMonyCubit>().addMony(
                      -widget.packageSelectModel.packageData.moneyPackage);
                }
                setState(() {
                  bselect = value;
                });
              })
        ],
      ),
    );
  }
}
