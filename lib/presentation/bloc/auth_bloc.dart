import 'package:bloc/bloc.dart';
import 'package:delivery_manager/domain/repository/domain_repositery.dart';
import 'package:delivery_manager/inject.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<LoginEvent>((event, emit) async {
      print(event.email);
      emit(AuthinProgressState());
      await getIt<DomainRepostory>().login(event.email, event.pwd);
      emit(LoginSuccessState());
    });
    on<IsAuth>((event, emit) async {
      emit(AuthinProgressState());
      await Future.delayed(Duration(seconds: 10));
      emit(AuthSiccafluid());
    });
  }
}
