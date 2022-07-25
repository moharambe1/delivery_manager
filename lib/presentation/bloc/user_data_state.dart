part of 'user_data_bloc.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object> get props => [];
}

class UserDataInitial extends UserDataState {}

class UserDataLeadingState extends UserDataState {}

class UserDataLeadedState extends UserDataState {
  final List<PackageSelectModel> packages;
  final String name;

  const UserDataLeadedState({required this.packages, required this.name});

  @override
  List<Object> get props => [name, packages];
}

class UserFoundState extends UserDataState {
  final int id;
  final String name;
  const UserFoundState({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];
}

class UserNotFound extends UserDataState {}
