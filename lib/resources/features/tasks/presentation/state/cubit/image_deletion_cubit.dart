import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImageDeletionCubit extends Cubit<List<XFile?>> {
  ImageDeletionCubit() : super([]);

  void setImages(List<XFile?> images) {
    emit(images);
  }

  void deleteImage(int index) {
    final updatedImages = List<XFile?>.from(state);
    if (index >= 0 && index < updatedImages.length) {
      updatedImages.removeAt(index);
      emit(updatedImages);
    }
  }
}
