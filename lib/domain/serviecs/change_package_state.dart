// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:delivery_manager/models/package_model.dart';

@injectable
class SerChangePackageState {
  Dio dio;
  SerChangePackageState({required this.dio});
  Future<bool> request(int id, StatePackageEnum newState) async {
    try {
      await dio.post('/api/package/changeState', data: {
        "package": {"id": id, "newState": newState.name}
      });

      return true;
    } catch (e) {
      if (e is DioError) {
        print(e.response?.data ?? e);
      } else {
        print(e);
      }
      return false;
    }
  }
}
