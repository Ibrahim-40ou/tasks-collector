import '../../../../core/utils/result.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../datasources/tasks_datasource.dart';
import '../models/task_model.dart';

class TasksRepositoryImpl extends TasksRepository {
  final TasksDatasource tasksDatasource;

  TasksRepositoryImpl({required this.tasksDatasource});

  @override
  Future<Result<void>> fetchTasks() async {
    return await tasksDatasource.fetchTasks();
  }

  @override
  Future<Result<void>> addTask(TaskModel task) async {
    return await tasksDatasource.addTask(task);
  }

  @override
  Future<Result<void>> deleteTask(int id) async {
    return await tasksDatasource.deleteTask(id);
  }

  @override
  Future<Result<void>> paginatedFetch(int perPage) async {
    return await tasksDatasource.paginatedFetch(perPage);
  }

  @override
  Future<Result<void>> fetchTaskByID(String id) async {
    return await tasksDatasource.fetchTaskByID(id);
  }
}
