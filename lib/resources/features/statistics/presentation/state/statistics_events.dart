part of 'statistics_bloc.dart';

@immutable
sealed class StatisticsEvents {}

class TotalComplaintsEvent extends StatisticsEvents {
  final List<ComplaintEntity> complaints;

  TotalComplaintsEvent({required this.complaints});
}

class ApprovedComplaintsEvent extends StatisticsEvents {
  final List<ComplaintEntity> complaints;

  ApprovedComplaintsEvent({required this.complaints});
}

class PendingComplaintsEvent extends StatisticsEvents {
  final List<ComplaintEntity> complaints;

  PendingComplaintsEvent({required this.complaints});
}

class RejectedComplaintsEvent extends StatisticsEvents {
  final List<ComplaintEntity> complaints;

  RejectedComplaintsEvent({required this.complaints});
}

class ProcessingComplaintsEvent extends StatisticsEvents {
  final List<ComplaintEntity> complaints;

  ProcessingComplaintsEvent({required this.complaints});
}
