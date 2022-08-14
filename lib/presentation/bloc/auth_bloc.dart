import 'package:bloc/bloc.dart';
import 'package:delivery_manager/domain/repository/domain_repositery.dart';
import 'package:delivery_manager/inject.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<LoginEvent>((event, emit) async {
      if (kDebugMode) {
        print(event.email);
      }
      emit(AuthinProgressState());
      final res = await getIt<DomainRepostory>().login(event.email, event.pwd);
      if (res) {
        emit(LoginSuccessState());
      } else {
        EasyLoading.showError("فـشل تـسجـيل الدخـول",
            duration: const Duration(seconds: 2));
        emit(LoginFailedState());
      }
    });
    on<IsAuth>((event, emit) async {
      emit(AuthinProgressState());
      await Future.delayed(const Duration(seconds: 10));
      emit(AuthSiccafluid());
    });
  }
}
