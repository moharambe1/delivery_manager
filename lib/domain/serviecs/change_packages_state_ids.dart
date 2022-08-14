// ignore_for_file: avoid_print

import 'package:delivery_manager/models/package_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class SerSetPackagesStateByID {
  final Dio dio;
  const SerSetPackagesStateByID({required this.dio});
  Future<bool> request(StatePackageEnum newState, List<int> ids) async {
    try {
      await dio.post('/manager/api/setPackageStateByIds', data: {
        "packages": {"ids": ids, "newState": newState.name}
      });
      print(ids);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
