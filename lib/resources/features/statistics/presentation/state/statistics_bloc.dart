import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../tasks/domain/entities/task_entity.dart';

part 'statistics_events.dart';

part 'statistics_states.dart';

class StatisticsBloc extends Bloc<StatisticsEvents, StatisticsStates> {
  StatisticsBloc() : super(StatisticsInitial()) {
    on<TotalTasksEvent>(_totalTasks);
    on<PendingTasksEvent>(_pendingTasks);
    on<ApprovedTasksEvent>(_approvedTasks);
    on<RejectedTasksEvent>(_rejectedTasks);
    on<ProcessingTasksEvent>(_processingTasks);
  }

  void _totalTasks(
    TotalTasksEvent event,
    Emitter<StatisticsStates> emit,
  ) {
    emit(TotalTasks(tasks: event.tasks));
  }

  void _pendingTasks(
    PendingTasksEvent event,
    Emitter<StatisticsStates> emit,
  ) {
    final pendingTasks =
        event.tasks.where((task) => task.statusId == 1).toList();
    emit(PendingTasks(tasks: pendingTasks));
  }

  void _processingTasks(
    ProcessingTasksEvent event,
    Emitter<StatisticsStates> emit,
  ) {
    final processingTasks =
        event.tasks.where((task) => task.statusId == 2).toList();
    emit(ProcessingTasks(tasks: processingTasks));
  }

  void _rejectedTasks(
    RejectedTasksEvent event,
    Emitter<StatisticsStates> emit,
  ) {
    final rejectedTasks =
        event.tasks.where((task) => task.statusId == 3).toList();
    emit(RejectedTasks(tasks: rejectedTasks));
  }

  void _approvedTasks(
    ApprovedTasksEvent event,
    Emitter<StatisticsStates> emit,
  ) {
    final approvedTasks =
        event.tasks.where((task) => task.statusId == 4).toList();
    emit(ApprovedTasks(tasks: approvedTasks));
  }
}
