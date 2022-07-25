import 'package:bloc/bloc.dart';
import 'package:delivery_manager/domain/repository/domain_repositery.dart';
import 'package:delivery_manager/inject.dart';
import 'package:delivery_manager/models/package_model.dart';
import 'package:delivery_manager/models/package_select_model.dart';
import 'package:equatable/equatable.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc() : super(UserDataInitial()) {
    on<GetUserPackageForUserEvent>((event, emit) async {
      emit(UserDataLeadingState());
      final data = await getIt<DomainRepostory>()
          .getUserPackages(event.statePackage, event.phone);
      final packsSlec = <PackageSelectModel>[];
      for (var i = 0; i < (data.item1.length); i++) {
        packsSlec.add(
            PackageSelectModel(packageData: data.item1[i], isSelect: false));
      }
      emit(UserDataLeadedState(packages: packsSlec, name: data.item2));
    });
    on<ChangeUserPackagesStateEvent>((event, emit) async {
      emit(UserDataLeadingState());
      List<int> data = <int>[];
      for (var element in event.packSels) {
        final id = element.packageData.id;
        if (element.isSelect && id != null) {
          data.add(id);
        }
      }
      await getIt<DomainRepostory>()
          .changePackagesByIds(event.statePackage, data);

      emit(UserDataInitial());
    });
    on<GetUserIdEvent>((event, emit) async {
      emit(UserDataLeadingState());
      final data = await getIt<DomainRepostory>().getUserData(event.phone);
      if (data != null) {
        emit(UserFoundState(id: data.item1, name: data.item2));
      } else {
        emit(UserNotFound());
      }
    });
    on<GetAllUserPackagsEvent>((event, emit) async {
      emit(UserDataLeadingState());
      final data =
          await getIt<DomainRepostory>().getPackagesWithState(event.state);
      final packsSlec = <PackageSelectModel>[];
      for (var i = 0; i < (data.length); i++) {
        packsSlec
            .add(PackageSelectModel(packageData: data[i], isSelect: false));
      }
      emit(UserDataLeadedState(packages: packsSlec, name: "الجـميـع"));
    });
  }
}
