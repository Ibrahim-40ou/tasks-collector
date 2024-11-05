import 'package:flutter_bloc/flutter_bloc.dart';

class CounterOpacityCubit extends Cubit<double> {
  CounterOpacityCubit() : super(0.0);

  void showCounter() => emit(1.0);

  void hideCounter() => emit(0.0);
}
