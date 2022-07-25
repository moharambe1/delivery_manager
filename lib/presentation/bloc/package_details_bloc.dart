import 'package:bloc/bloc.dart';
import 'package:delivery_manager/domain/repository/domain_repositery.dart';
import 'package:delivery_manager/inject.dart';
import 'package:delivery_manager/models/package_model.dart';
import 'package:equatable/equatable.dart';

part 'package_details_event.dart';
part 'package_details_state.dart';

class PackageDetailsBloc
    extends Bloc<PackageDetailsEvent, PackageDetailsState> {
  PackageDetailsBloc() : super(PackageDetailsInitial()) {
    on<ChangePackageStateEvent>((event, emit) async {
      emit(PackageLoadingState());
      await getIt<DomainRepostory>()
          .changePackageState(event.id, event.newState);
      emit(PackageDetailsInitial());
    });
    on<GetPackageDetailsEvent>((event, emit) async {
      emit(PackageLoadingState());
      final res = await getIt<DomainRepostory>().getPackageWithId(event.id);
      if (res != null && res.item2 != null) {
        emit(PackageLoadedState(phone: res.item1, package: res.item2!));
      } else {
        emit(PackageDetailsError());
      }
    });
  }
}
