part of 'user_data_bloc.dart';

abstract class UserDataEvent extends Equatable {
  const UserDataEvent();

  @override
  List<Object> get props => [];
}

class GetUserPackageForUserEvent extends UserDataEvent {
  final String phone;
  final StatePackageEnum statePackage;
  const GetUserPackageForUserEvent(
      {required this.phone, required this.statePackage});

  @override
  List<Object> get props => [phone];
}

class ChangeUserPackagesStateEvent extends UserDataEvent {
  final List<PackageSelectModel> packSels;
  final StatePackageEnum statePackage;
  const ChangeUserPackagesStateEvent({
    required this.packSels,
    required this.statePackage,
  });

  @override
  List<Object> get props => [packSels, statePackage];
}

class GetUserIdEvent extends UserDataEvent {
  final String phone;
  const GetUserIdEvent({required this.phone});
  @override
  List<Object> get props => [phone];
}

class GetAllUserPackagsEvent extends UserDataEvent {
  final StatePackageEnum state;
  const GetAllUserPackagsEvent({required this.state});
  @override
  List<Object> get props => [state];
}
