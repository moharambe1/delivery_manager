import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';

@injectable
class SerLoginAuth {
  final Dio dio;
  SerLoginAuth({
    required this.dio,
  });

  Future<bool> request(String email, String pwd) async {
    try {
      final res = await dio.post('/manager/api/signin', data: {
        "account": {
          "email": "m1",
          "pwd": "123456",
          "phoneNumber": "0114587",
          "accountRole": "MANAGER"
        }
      });
      print(res);

      return true;
    } catch (e) {
      if (e is DioError) {
        if (e.response!.data) EasyLoading.showError(e.response!.data);
      } else {
        print(e);
      }
      return false;
    }
  }
}
