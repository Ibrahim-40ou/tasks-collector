part of 'complaints_bloc.dart';

@immutable
sealed class ComplaintsStates {}

class ComplaintsInitial extends ComplaintsStates {}

class FetchComplaintsLoading extends ComplaintsStates {}

class FetchComplaintsSuccess extends ComplaintsStates {
  final List<ComplaintEntity> complaints;

  FetchComplaintsSuccess({required this.complaints});
}

class FetchComplaintsFailure extends ComplaintsStates {
  final String? failure;

  FetchComplaintsFailure({required this.failure});
}

class AddComplaintLoading extends ComplaintsStates {}

class AddComplaintSuccess extends ComplaintsStates {}

class AddComplaintFailure extends ComplaintsStates {
  final String? failure;

  AddComplaintFailure({required this.failure});
}


class DeleteComplaintLoading extends ComplaintsStates {}

class DeleteComplaintSuccess extends ComplaintsStates {}

class DeleteComplaintFailure extends ComplaintsStates {
  final String? failure;

  DeleteComplaintFailure({required this.failure});
}

class NoImagesState extends ComplaintsStates {}

class UploadedOfflineComplaintsLoading extends ComplaintsStates {}

class UploadedOfflineComplaintsSuccess extends ComplaintsStates {}

class UploadedOfflineComplaintsFailure extends ComplaintsStates {
  final String? failure;
  UploadedOfflineComplaintsFailure({required this.failure});
}


class DeletedOfflineComplaintsLoading extends ComplaintsStates {}

class DeletedOfflineComplaintsSuccess extends ComplaintsStates {}

class DeletedOfflineComplaintsFailure extends ComplaintsStates {
  final String? failure;
  DeletedOfflineComplaintsFailure({required this.failure});
}

