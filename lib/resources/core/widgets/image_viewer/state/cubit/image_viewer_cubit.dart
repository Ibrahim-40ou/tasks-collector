import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ImageViewerCubit extends Cubit<int> {
  final PageController pageController;

  ImageViewerCubit(super.initialIndex)
      : pageController = PageController(initialPage: initialIndex) {
    pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    emit(pageController.page?.round() ?? 0);
  }

  void updateIndex(int index) {
    pageController.jumpToPage(index);
    emit(index);
  }

  void reset() {
    emit(0);
  }

  @override
  Future<void> close() {
    pageController.removeListener(_onPageChanged);
    pageController.dispose();
    return super.close();
  }
}
