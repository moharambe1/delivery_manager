import 'dart:developer';

import 'package:delivery_manager/models/anoun_client_model.dart';
import 'package:delivery_manager/models/package_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';
import 'package:tuple/tuple.dart';

@injectable
class SerAddPackage {
  Dio dio;
  SerAddPackage({required this.dio});
  Future<Tuple2<bool, int?>> request(
      AnounClientModel anounClientModel, PackageModel packageModel) async {
    try {
      if (kDebugMode) {
        print(anounClientModel.toJson());
      }
      var response = await dio.post('/manager/api/addPackage',
          data: {"account": anounClientModel, "package": packageModel});

      return Tuple2(true, response.data['id']);
    } catch (e) {
      if (e is DioError) {
        EasyLoading.showError(e.response?.data.toString() ?? "حصل خطأ",
            duration: const Duration(seconds: 2));
        log(e.response?.data.toString() ?? e.toString());
      } else {
        EasyLoading.showError("حصل خطأ", duration: const Duration(seconds: 2));
        log(e.toString());
      }

      return const Tuple2(false, null);
    }
  }
}
