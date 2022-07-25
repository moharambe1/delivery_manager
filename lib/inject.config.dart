// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'domain/repository/domain_repositery.dart' as _i12;
import 'domain/serviecs/add_packages.dart' as _i3;
import 'domain/serviecs/change_package_state.dart' as _i5;
import 'domain/serviecs/change_packages_state_ids.dart' as _i11;
import 'domain/serviecs/get_package_id.dart' as _i6;
import 'domain/serviecs/get_packages_state.dart' as _i7;
import 'domain/serviecs/get_packages_user.dart' as _i9;
import 'domain/serviecs/get_user_data.dart' as _i8;
import 'domain/serviecs/login_auth.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.SerAddPackage>(() => _i3.SerAddPackage(dio: get<_i4.Dio>()));
  gh.factory<_i5.SerChangePackageState>(
      () => _i5.SerChangePackageState(dio: get<_i4.Dio>()));
  gh.factory<_i6.SerGetPackagesWithId>(
      () => _i6.SerGetPackagesWithId(dio: get<_i4.Dio>()));
  gh.factory<_i7.SerGetPackagesWithState>(
      () => _i7.SerGetPackagesWithState(dio: get<_i4.Dio>()));
  gh.factory<_i8.SerGetUserData>(() => _i8.SerGetUserData(dio: get<_i4.Dio>()));
  gh.factory<_i9.SerGetUserPackages>(
      () => _i9.SerGetUserPackages(dio: get<_i4.Dio>()));
  gh.factory<_i10.SerLoginAuth>(() => _i10.SerLoginAuth(dio: get<_i4.Dio>()));
  gh.factory<_i11.SerSetPackagesStateByID>(
      () => _i11.SerSetPackagesStateByID(dio: get<_i4.Dio>()));
  gh.factory<_i12.DomainRepostory>(() => _i12.DomainRepostory(
      serGetPackagesWithState: get<_i7.SerGetPackagesWithState>(),
      serGetUserPackages: get<_i9.SerGetUserPackages>(),
      serChangePackagesStateByIds: get<_i11.SerSetPackagesStateByID>(),
      serLoginAuth: get<_i10.SerLoginAuth>(),
      serAddPackage: get<_i3.SerAddPackage>(),
      serGetPackagesWithId: get<_i6.SerGetPackagesWithId>(),
      serChangePackageState: get<_i5.SerChangePackageState>(),
      serGetUserData: get<_i8.SerGetUserData>()));
  return get;
}
