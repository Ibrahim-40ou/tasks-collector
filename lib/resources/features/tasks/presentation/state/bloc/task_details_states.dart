part of 'task_details_bloc.dart';

sealed class TaskDetailsStates {}

class TaskDetailsInitial extends TaskDetailsStates {}


class FetchTaskByIDLoading extends TaskDetailsStates {}

class FetchTaskByIDSuccess extends TaskDetailsStates {
  final TaskEntity task;

  FetchTaskByIDSuccess({required this.task});
}

class FetchTaskByIDFailure extends TaskDetailsStates {
  final String? failure;

  FetchTaskByIDFailure({required this.failure});
}