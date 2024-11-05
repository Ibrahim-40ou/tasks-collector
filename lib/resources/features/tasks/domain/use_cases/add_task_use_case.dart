import '../../../../core/utils/result.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/tasks_repository_impl.dart';

class AddTaskUseCase {
  final TasksRepositoryImpl tasksRepositoryImpl;

  AddTaskUseCase({required this.tasksRepositoryImpl});

  Future<Result<void>> call(TaskModel task) async {
    return await tasksRepositoryImpl.addTask(task);
  }
}
