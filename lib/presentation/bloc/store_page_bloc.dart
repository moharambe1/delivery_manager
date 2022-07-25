import 'package:bloc/bloc.dart';
import 'package:delivery_manager/domain/repository/domain_repositery.dart';
import 'package:delivery_manager/inject.dart';
import 'package:delivery_manager/models/package_model.dart';
import 'package:equatable/equatable.dart';

part 'store_page_event.dart';
part 'store_page_state.dart';

class StorePageBloc extends Bloc<StorePageEvent, StorePageState> {
  StorePageBloc() : super(StorePageInitialState()) {
    on<GetPackagesEvent>((event, emit) async {
      emit(StorePageLoadingState());
      final res =
          await getIt<DomainRepostory>().getPackagesWithState(event.state);
      emit(PackagesLoadedeState(packages: res));
    }); /*
    on<PayPackagesForUserEvent>(((event, emit) async {
      emit(StorePageLoadingState());
      final res = await getIt<DomainRepostory>()
          .changePackagesByIds(event.phone, event.ids);
      emit(StorePagesSucceededState());
    }));*/
  }
}
