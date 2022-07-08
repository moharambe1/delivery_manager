// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'domain/repository/domain_repositery.dart' as _i9;
import 'domain/serviecs/add_packages.dart' as _i3;
import 'domain/serviecs/get_packages.dart' as _i5;
import 'domain/serviecs/get_packages_user.dart' as _i6;
import 'domain/serviecs/login_auth.dart' as _i7;
import 'domain/serviecs/py_packages_user.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.SerAddPackage>(() => _i3.SerAddPackage(dio: get<_i4.Dio>()));
  gh.factory<_i5.SerGetPackages>(() => _i5.SerGetPackages());
  gh.factory<_i6.SerGetPackagesUser>(() => _i6.SerGetPackagesUser());
  gh.factory<_i7.SerLoginAuth>(() => _i7.SerLoginAuth(dio: get<_i4.Dio>()));
  gh.factory<_i8.SerPayPackages>(() => _i8.SerPayPackages());
  gh.factory<_i9.DomainRepostory>(() => _i9.DomainRepostory(
      serGetPackages: get<_i5.SerGetPackages>(),
      serGetPackagesUser: get<_i6.SerGetPackagesUser>(),
      serPayPackages: get<_i8.SerPayPackages>(),
      serLoginAuth: get<_i7.SerLoginAuth>(),
      serAddPackage: get<_i3.SerAddPackage>()));
  return get;
}
