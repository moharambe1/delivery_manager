// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
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
class SerGetPackagesWithState {
  Dio dio;
  SerGetPackagesWithState({required this.dio});
  Future<List<PackageModel>> request(StatePackageEnum state) async {
    try {
      var response = await dio.post('/manager/api/getPakagesWithState',
          data: {'state': state.name});
      final rows = response.data as List<dynamic>?;
      final tmp = <PackageModel>[];
      if (rows?.isNotEmpty ?? false) {
        // ignore: avoid_function_literals_in_foreach_calls
        rows?.forEach((element) {
          tmp.add(PackageModel.fromMap(element));
        });
      }
      print(tmp);
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
