part of 'statistics_bloc.dart';

@immutable
sealed class StatisticsEvents {}

class TotalTasksEvent extends StatisticsEvents {
  final List<TaskEntity> tasks;

  TotalTasksEvent({required this.tasks});
}

class ApprovedTasksEvent extends StatisticsEvents {
  final List<TaskEntity> tasks;

  ApprovedTasksEvent({required this.tasks});
}

class PendingTasksEvent extends StatisticsEvents {
  final List<TaskEntity> tasks;

  PendingTasksEvent({required this.tasks});
}

class RejectedTasksEvent extends StatisticsEvents {
  final List<TaskEntity> tasks;

  RejectedTasksEvent({required this.tasks});
}

class ProcessingTasksEvent extends StatisticsEvents {
  final List<TaskEntity> tasks;

  ProcessingTasksEvent({required this.tasks});
}
