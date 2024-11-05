import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'image_selection_events.dart';

part 'image_selection_states.dart';

class ImageSelectionBloc
    extends Bloc<ImageSelectionEvent, ImageSelectionState> {
  ImageSelectionBloc() : super(ImageSelectionInitialState()) {
    on<SelectImageRequest>(_selectImage);
    on<StopImageSelection>(_stopImageSelection);
  }

  Future<void> _selectImage(
    SelectImageRequest event,
    Emitter<ImageSelectionState> emit,
  ) async {
    return emit(SelectImageSuccess(selectedImages: event.selectedImages));
  }

  Future<void> _stopImageSelection(
    StopImageSelection event,
    Emitter<ImageSelectionState> emit,
  ) async {
    return emit(StoppedImageSelection());
  }
}
