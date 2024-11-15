part of 'tasks_bloc.dart';

@immutable
sealed class TasksStates {}

class TasksInitial extends TasksStates {}

class FetchTasksLoading extends TasksStates {}

class FetchTasksSuccess extends TasksStates {
  final List<TaskEntity> tasks;

  FetchTasksSuccess({required this.tasks});
}

class FetchTasksFailure extends TasksStates {
  final String? failure;

  FetchTasksFailure({required this.failure});
}

class AddTaskLoading extends TasksStates {}

class AddTaskSuccess extends TasksStates {}

class AddTaskFailure extends TasksStates {
  final String? failure;

  AddTaskFailure({required this.failure});
}

class DeleteTaskLoading extends TasksStates {}

class DeleteTaskSuccess extends TasksStates {}

class DeleteTaskFailure extends TasksStates {
  final String? failure;

  DeleteTaskFailure({required this.failure});
}

class NoImagesState extends TasksStates {}

class UploadedOfflineTasksLoading extends TasksStates {}

class UploadedOfflineTasksSuccess extends TasksStates {}

class UploadedOfflineTasksFailure extends TasksStates {
  final String? failure;

  UploadedOfflineTasksFailure({required this.failure});
}

class DeletedOfflineTasksLoading extends TasksStates {}

class DeletedOfflineTasksSuccess extends TasksStates {}

class DeletedOfflineTasksFailure extends TasksStates {
  final String? failure;

  DeletedOfflineTasksFailure({required this.failure});
}

