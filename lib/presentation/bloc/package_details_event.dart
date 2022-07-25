part of 'package_details_bloc.dart';

abstract class PackageDetailsEvent extends Equatable {
  const PackageDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetPackageDetailsEvent extends PackageDetailsEvent {
  final int id;
  const GetPackageDetailsEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class ChangePackageStateEvent extends PackageDetailsEvent {
  final int id;
  final StatePackageEnum newState;
  const ChangePackageStateEvent({required this.id, required this.newState});

  @override
  List<Object> get props => [id, newState];
}
