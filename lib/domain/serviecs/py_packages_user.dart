// ignore_for_file: avoid_print

import 'package:injectable/injectable.dart';

@injectable
class SerPayPackages {
  //Dio dio;
  SerPayPackages();
  Future<bool> request(String phone, List<int> ids) async {
    try {
      //var response = await dio.get('/admin/getPackaes',queryParameters: );
      print(ids);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
