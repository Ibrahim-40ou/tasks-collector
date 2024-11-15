import '../../data/models/task_model.dart';

abstract class TasksRepository {
  Future<void> fetchTasks();

  Future<void> addTask(TaskModel task);

  Future<void> deleteTask(int id);

  Future<void> paginatedFetch(int perPage);

  Future<void> fetchTaskByID(String id);
}
