import 'package:delivery_manager/models/package_model.dart';

class PackageSelectModel {
  PackageModel packageData;
  bool isSelect;
  PackageSelectModel({required this.packageData, this.isSelect = false});
}
