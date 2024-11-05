import '../../../../core/utils/result.dart';
import '../../data/repositories/tasks_repository_impl.dart';

class DeleteTasksUseCase {
  final TasksRepositoryImpl tasksRepositoryImpl;

  DeleteTasksUseCase({required this.tasksRepositoryImpl});

  Future<Result<void>> call(int id) async {
    return await tasksRepositoryImpl.deleteTask(id);
  }
}
