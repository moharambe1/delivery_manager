import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';
import 'package:tuple/tuple.dart';

@injectable
class SerGetUserData {
  Dio dio;
  SerGetUserData({required this.dio});
  Future<Tuple2<int, String>?> requestId(String phone) async {
    try {
      var response =
          await dio.post('/manager/api/getUserId', data: {'phone': phone});
      final data = response.data;

      return Tuple2(data['id'], data['name']);
    } catch (e) {
      if (e is DioError) {
        EasyLoading.showError(e.response?.data ?? "حصل خـظأ",
            duration: const Duration(seconds: 2));
        print(e.response?.data ?? e);
      } else {
        print(e);
      }
      return null;
    }
  }

  Future<Tuple2<int, String>?> requestPhone(int id) async {
    try {
      var response = await dio.post('/manager/api/getUserId', data: {'id': id});
      final data = response.data;

      return Tuple2(data['id'], data['name']);
    } catch (e) {
      if (e is DioError) {
        EasyLoading.showError(e.response?.data ?? "حصل خـظأ",
            duration: const Duration(seconds: 2));
        print(e.response?.data ?? e);
      } else {
        print(e);
      }
      return null;
    }
  }
}
