part of 'complaints_bloc.dart';

@immutable
sealed class ComplaintsEvents {}

class FetchComplaints extends ComplaintsEvents {}

class AddComplaint extends ComplaintsEvents {
  final ComplaintModel complaint;

  AddComplaint({required this.complaint});
}

class DeleteComplaint extends ComplaintsEvents {
  final int id;
  final int index;

  DeleteComplaint({
    required this.id,
    required this.index,
  });
}

class NoImages extends ComplaintsEvents {}

class UploadOfflineComplaints extends ComplaintsEvents {}

class DeleteOfflineComplaints extends ComplaintsEvents {}

class SerializationEvent extends ComplaintsEvents {}