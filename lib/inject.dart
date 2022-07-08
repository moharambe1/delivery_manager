// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// ignore: depend_on_referenced_packages

import 'inject.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() => $initGetIt(getIt);
