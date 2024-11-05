import 'package:flutter_bloc/flutter_bloc.dart';

class ImageCounterCubit extends Cubit<int> {
  ImageCounterCubit() : super(0);

  void changeImage(int index) {
    emit(index);
  }
}
