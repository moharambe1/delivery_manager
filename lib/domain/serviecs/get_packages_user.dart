// ignore_for_file: avoid_print

import 'package:injectable/injectable.dart';
import 'package:delivery_manager/models/package_model.dart';

List<PackageModel> tPackages = const [
  PackageModel(
      id: 1,
      fullName: "ahmed",
      phoneNumber: "0771000000",
      statePackage: StatePackageEnum.RECEIVED,
      stateMoney: StatsMoneyEnum.CLIENT,
      stateMoneyDelivring: StatsMoneyDeliveringEnum.CLIENT,
      address: "حي الحوزة",
      moneyDelivring: 1000),
  PackageModel(
      id: 2,
      fullName: "achraf",
      phoneNumber: "0771000000",
      statePackage: StatePackageEnum.DELEVERED,
      stateMoney: StatsMoneyEnum.CLIENT,
      stateMoneyDelivring: StatsMoneyDeliveringEnum.CLIENT,
      address: "حي البخاري",
      moneyDelivring: 10000)
];

@injectable
class SerGetPackagesUser {
  //Dio dio;
  SerGetPackagesUser();
  Future<List<PackageModel>> request(
      StatePackageEnum state, String phone) async {
    try {
      //var response = await dio.get('/admin/getPackaes',queryParameters: );
      final tmp =
          await Future.delayed(const Duration(seconds: 10)).then((value) {
        return tPackages;
      });
      return tmp;
    } catch (e) {
      print(e);
      final tmp =
          await Future.delayed(const Duration(seconds: 10)).then((value) {
        return <PackageModel>[];
      });
      return tmp;
    }
  }
}
