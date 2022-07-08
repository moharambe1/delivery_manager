import 'package:delivery_manager/domain/serviecs/add_packages.dart';
import 'package:delivery_manager/domain/serviecs/get_packages.dart';
import 'package:delivery_manager/domain/serviecs/get_packages_user.dart';
import 'package:delivery_manager/domain/serviecs/login_auth.dart';
import 'package:delivery_manager/domain/serviecs/py_packages_user.dart';
import 'package:delivery_manager/models/anoun_client_model.dart';
import 'package:delivery_manager/models/package_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class DomainRepostory {
  final SerGetPackages serGetPackages;
  final SerGetPackagesUser serGetPackagesUser;
  final SerPayPackages serPayPackages;
  final SerLoginAuth serLoginAuth;
  final SerAddPackage serAddPackage;

  DomainRepostory(
      {required this.serGetPackages,
      required this.serGetPackagesUser,
      required this.serPayPackages,
      required this.serLoginAuth,
      required this.serAddPackage});

  Future<bool> login(String email, String pwd) async {
    return await serLoginAuth.request(email, pwd);
  }

  Future<List<PackageModel>> getPackages(StatePackageEnum state) async {
    return await serGetPackages.request(state);
  }

  Future<List<PackageModel>> getPackagesForUser(
      StatePackageEnum state, String number) async {
    return await serGetPackagesUser.request(state, number);
  }

  Future<bool> payPackagesForUser(String phone, List<int> ids) async {
    return await serPayPackages.request(phone, ids);
  }

  Future<bool> addPackage(
      AnounClientModel anounClientModel, PackageModel packageModel) async {
    return await serAddPackage.request(anounClientModel, packageModel);
  }
}
