import 'package:delivery_manager/models/anoun_client_model.dart';
import 'package:delivery_manager/models/package_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class SerAddPackage {
  Dio dio;
  SerAddPackage({required this.dio});
  Future<bool> request(
      AnounClientModel anounClientModel, PackageModel packageModel) async {
    try {
      print(anounClientModel.toJson());
      var response = await dio.post('/manager/api/addPackage',
          data: {"account": anounClientModel, "package": packageModel});

      return true;
    } catch (e) {
      if (e is DioError) {
        print(e.response?.data ?? "");
      } else {
        print(e);
      }
      return false;
    }
  }
}
