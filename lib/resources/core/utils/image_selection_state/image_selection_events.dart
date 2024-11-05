part of 'image_selection_bloc.dart';

@immutable
abstract class ImageSelectionEvent {}

class SelectImageRequest extends ImageSelectionEvent {
  final List<XFile?> selectedImages;

  SelectImageRequest({required this.selectedImages});
}

class StopImageSelection extends ImageSelectionEvent {}
