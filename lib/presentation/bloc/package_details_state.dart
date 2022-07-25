part of 'package_details_bloc.dart';

abstract class PackageDetailsState extends Equatable {
  const PackageDetailsState();

  @override
  List<Object> get props => [];
}

class PackageDetailsInitial extends PackageDetailsState {}

class PackageLoadingState extends PackageDetailsState {}

class PackageLoadedState extends PackageDetailsState {
  final PackageModel package;
  final String phone;
  const PackageLoadedState({required this.phone, required this.package});
  @override
  List<Object> get props => [phone, package];
}

class PackageDetailsError extends PackageDetailsState {}
