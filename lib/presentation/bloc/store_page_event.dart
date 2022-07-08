part of 'store_page_bloc.dart';

abstract class StorePageEvent extends Equatable {
  const StorePageEvent();

  @override
  List<Object> get props => [];
}

class GetPackagesEvent extends StorePageEvent {
  final StatePackageEnum state;
  const GetPackagesEvent({required this.state});
  @override
  List<Object> get props => [state];
}

class GetPackagesForUserEvent extends StorePageEvent {
  final String phone;
  const GetPackagesForUserEvent({
    required this.phone,
  });

  @override
  List<Object> get props => [phone];
}

class PayPackagesForUserEvent extends StorePageEvent {
  final String phone;
  final List<int> ids;
  const PayPackagesForUserEvent({
    required this.phone,
    required this.ids,
  });

  @override
  List<Object> get props => [phone, ids];
}
