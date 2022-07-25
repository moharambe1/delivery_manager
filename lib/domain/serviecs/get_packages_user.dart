// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:delivery_manager/models/package_model.dart';
import 'package:tuple/tuple.dart';

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
class SerGetUserPackages {
  final Dio dio;
  SerGetUserPackages({required this.dio});
  Future<Tuple2<List<PackageModel>, String>> request(
      StatePackageEnum state, String phone) async {
    try {
      var response = await dio.post('/manager/api/getUserPackagesWithState',
          data: {"phone": phone, "state": state.name});

      final packs = <PackageModel>[];
      final res = response.data['packages'] as List?;
      for (var i = 0; i < (res?.length ?? 0); i++) {
        packs.add(PackageModel.fromMap(res?[i]));
      }

      final data =
          Tuple2<List<PackageModel>, String>(packs, response.data['name']);
      return data;
    } catch (e) {
      if (e is DioError) {
        print(e.response?.data ?? e);
      } else {
        print(e);
      }
      final tmp =
          await Future.delayed(const Duration(seconds: 1)).then((value) {
        return <PackageModel>[];
      });
      return Tuple2<List<PackageModel>, String>(tmp, "فشل");
    }
  }
}
