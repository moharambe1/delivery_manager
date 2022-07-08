part of 'package_bloc.dart';

abstract class PackageEvent extends Equatable {
  const PackageEvent();

  @override
  List<Object> get props => [];
}

class AddPackageEvent extends PackageEvent {
  final AnounClientModel anounClientModel;
  final PackageModel packageModel;
  const AddPackageEvent({
    required this.anounClientModel,
    required this.packageModel,
  });
  @override
  List<Object> get props => [anounClientModel, packageModel];
}
