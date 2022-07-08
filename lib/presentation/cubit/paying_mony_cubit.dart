import 'package:bloc/bloc.dart';

class PayingMonyCubit extends Cubit<int> {
  PayingMonyCubit() : super(0);

  void addMony(int amount) => emit(state + amount);
  void clear() => emit(0);
}
