part of 'statistics_bloc.dart';

@immutable
sealed class StatisticsStates {}

class StatisticsInitial extends StatisticsStates {}

class TotalComplaints extends StatisticsStates {
  final List<ComplaintEntity> complaints;

  TotalComplaints({required this.complaints});
}

class ApprovedComplaints extends StatisticsStates {
  final List<ComplaintEntity> complaints;

  ApprovedComplaints({required this.complaints});
}

class PendingComplaints extends StatisticsStates {
  final List<ComplaintEntity> complaints;

  PendingComplaints({required this.complaints});
}

class RejectedComplaints extends StatisticsStates {
  final List<ComplaintEntity> complaints;

  RejectedComplaints({required this.complaints});
}

class ProcessingComplaints extends StatisticsStates {
  final List<ComplaintEntity> complaints;

  ProcessingComplaints({required this.complaints});
}
