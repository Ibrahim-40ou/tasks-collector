part of 'image_selection_bloc.dart';

@immutable
abstract class ImageSelectionState {}

class ImageSelectionInitialState extends ImageSelectionState {}

class SelectImageSuccess extends ImageSelectionState {
  final List<XFile?> selectedImages;

  SelectImageSuccess({required this.selectedImages});
}

class StoppedImageSelection extends ImageSelectionState {}
