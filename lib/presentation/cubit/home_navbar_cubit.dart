import 'package:bloc/bloc.dart';

enum HomeNavBarEnum { home, delevring, paying, returning }

class HomeNavbarCubit extends Cubit<HomeNavBarEnum> {
  HomeNavbarCubit() : super(HomeNavBarEnum.home);

  void changePage(HomeNavBarEnum page) => emit(page);
}
