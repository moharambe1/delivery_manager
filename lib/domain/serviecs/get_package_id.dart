// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:delivery_manager/models/package_model.dart';
import 'package:tuple/tuple.dart';

@injectable
class SerGetPackagesWithId {
  Dio dio;
  SerGetPackagesWithId({required this.dio});
  Future<Tuple2<String, PackageModel?>?> request(int id) async {
    try {
      var resPack =
          await dio.post('/manager/api/getPackageWithId', data: {'id': id});

      var resPhone = await dio.post('/manager/api/getClientPhone',
          data: {'id': resPack.data['idanoun']});

      final data = resPack.data;

      final pack = PackageModel.fromMap(data);

      print(data);
      return Tuple2(resPhone.data['phone'] ?? "مجـهول", pack);
    } catch (e) {
      if (e is DioError) print(e.response?.data ?? e);
      print(e);
      return null;
    }
  }
}
