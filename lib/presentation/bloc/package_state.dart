part of 'package_bloc.dart';

abstract class PackageState extends Equatable {
  const PackageState();

  @override
  List<Object> get props => [];
}

class PackageInitial extends PackageState {}

class InProgressState extends PackageState {
  final String massage;
  const InProgressState({
    required this.massage,
  });
  @override
  List<Object> get props => [massage];
}

class AddedPackageSucceedState extends PackageState {
  final int idPack;
  const AddedPackageSucceedState({required this.idPack});

  @override
  List<Object> get props => [idPack];
}

class AddPackageErrorState extends PackageState {}
