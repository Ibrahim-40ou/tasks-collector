part of 'task_details_bloc.dart';

@immutable
sealed class TaskDetailsEvent {}


class FetchTaskByID extends TaskDetailsEvent {
  final String id;

  FetchTaskByID({required this.id});
}