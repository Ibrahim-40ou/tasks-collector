import '../../../../core/utils/result.dart';
import '../../data/repositories/tasks_repository_impl.dart';

class FetchTasksUseCase {
  final TasksRepositoryImpl tasksRepositoryImpl;

  FetchTasksUseCase({required this.tasksRepositoryImpl});

  Future<Result<void>> call() async {
    return await tasksRepositoryImpl.fetchTasks();
  }
}
