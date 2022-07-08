part of 'store_page_bloc.dart';

abstract class StorePageState extends Equatable {
  const StorePageState();

  @override
  List<Object> get props => [];
}

class StorePageInitialState extends StorePageState {}

class StorePageLoadingState extends StorePageState {}

class HomeStorePageState extends StorePageState {
  const HomeStorePageState();
}

class PackagesStorePageState extends HomeStorePageState {
  final List<PackageModel> packages;
  const PackagesStorePageState({
    required this.packages,
  });

  @override
  List<Object> get props => [packages];
}

class StorePagesSucceededState extends StorePageState {}
