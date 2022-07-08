import 'package:bloc/bloc.dart';
import 'package:delivery_manager/domain/repository/domain_repositery.dart';
import 'package:delivery_manager/inject.dart';
import 'package:delivery_manager/models/anoun_client_model.dart';
import 'package:delivery_manager/models/package_model.dart';
import 'package:equatable/equatable.dart';

part 'package_event.dart';
part 'package_state.dart';

class PackageBloc extends Bloc<PackageEvent, PackageState> {
  PackageBloc() : super(PackageInitial()) {
    on<AddPackageEvent>((event, emit) async {
      emit(const InProgressState(massage: "جاري اضافـة طرد"));
      await getIt<DomainRepostory>()
          .addPackage(event.anounClientModel, event.packageModel);

      emit(AddedPackageSucceedState());
    });
  }
}
