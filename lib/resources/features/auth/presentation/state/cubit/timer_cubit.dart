import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerState {
  final int remainingTime;
  final bool isButtonDisabled;

  TimerState(this.remainingTime, this.isButtonDisabled);
}

class TimerCubit extends Cubit<TimerState> {
  Timer? _timer;
  final int initialDuration;

  TimerCubit({this.initialDuration = 30}) : super(TimerState(30, true));

  void startTimer() {
    emit(TimerState(state.remainingTime, true));

    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        final secondsLeft = state.remainingTime - 1;
        if (secondsLeft <= 0) {
          _timer?.cancel();
          emit(TimerState(0, false));
        } else {
          emit(TimerState(secondsLeft, true));
        }
      },
    );
  }

  void resetTimer() {
    _timer?.cancel();
    emit(TimerState(initialDuration, true));
    startTimer();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
