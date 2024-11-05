part of 'statistics_bloc.dart';

@immutable
sealed class StatisticsStates {}

class StatisticsInitial extends StatisticsStates {}

class TotalTasks extends StatisticsStates {
  final List<TaskEntity> tasks;

  TotalTasks({required this.tasks});
}

class ApprovedTasks extends StatisticsStates {
  final List<TaskEntity> tasks;

  ApprovedTasks({required this.tasks});
}

class PendingTasks extends StatisticsStates {
  final List<TaskEntity> tasks;

  PendingTasks({required this.tasks});
}

class RejectedTasks extends StatisticsStates {
  final List<TaskEntity> tasks;

  RejectedTasks({required this.tasks});
}

class ProcessingTasks extends StatisticsStates {
  final List<TaskEntity> tasks;

  ProcessingTasks({required this.tasks});
}
