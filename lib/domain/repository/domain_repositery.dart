import 'package:delivery_manager/domain/serviecs/add_packages.dart';
import 'package:delivery_manager/domain/serviecs/change_package_state.dart';
import 'package:delivery_manager/domain/serviecs/get_package_id.dart';
import 'package:delivery_manager/domain/serviecs/get_packages_state.dart';
import 'package:delivery_manager/domain/serviecs/get_packages_user.dart';
import 'package:delivery_manager/domain/serviecs/get_user_data.dart';
import 'package:delivery_manager/domain/serviecs/login_auth.dart';
import 'package:delivery_manager/domain/serviecs/change_packages_state_ids.dart';
import 'package:delivery_manager/models/anoun_client_model.dart';
import 'package:delivery_manager/models/package_model.dart';
import 'package:injectable/injectable.dart';
import 'package:tuple/tuple.dart';

@injectable
class DomainRepostory {
  final SerGetPackagesWithState serGetPackagesWithState;
  final SerGetUserPackages serGetUserPackages;
  final SerSetPackagesStateByID serChangePackagesStateByIds;
  final SerLoginAuth serLoginAuth;
  final SerAddPackage serAddPackage;
  final SerGetPackagesWithId serGetPackagesWithId;
  final SerChangePackageState serChangePackageState;
  final SerGetUserData serGetUserData;
  DomainRepostory(
      {required this.serGetPackagesWithState,
      required this.serGetUserPackages,
      required this.serChangePackagesStateByIds,
      required this.serLoginAuth,
      required this.serAddPackage,
      required this.serGetPackagesWithId,
      required this.serChangePackageState,
      required this.serGetUserData});

  Future<bool> login(String email, String pwd) async {
    return await serLoginAuth.request(email, pwd);
  }

  Future<List<PackageModel>> getPackagesWithState(
      StatePackageEnum state) async {
    return await serGetPackagesWithState.request(state);
  }

  Future<Tuple2<List<PackageModel>, String>> getUserPackages(
      StatePackageEnum state, String number) async {
    return await serGetUserPackages.request(state, number);
  }

  Future<bool> changePackagesByIds(
      StatePackageEnum newState, List<int> ids) async {
    return await serChangePackagesStateByIds.request(newState, ids);
  }

  Future<Tuple2<bool, int?>> addPackage(
      AnounClientModel anounClientModel, PackageModel packageModel) async {
    return await serAddPackage.request(anounClientModel, packageModel);
  }

  Future<Tuple2<String, PackageModel?>?> getPackageWithId(int id) async {
    return await serGetPackagesWithId.request(id);
  }

  Future<bool> changePackageState(int id, StatePackageEnum newState) async {
    return await serChangePackageState.request(id, newState);
  }

  Future<Tuple2<int, String>?> getUserData(String phone) async {
    return await serGetUserData.requestId(phone);
  }
}
