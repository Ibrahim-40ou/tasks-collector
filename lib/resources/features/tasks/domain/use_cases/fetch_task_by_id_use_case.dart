import '../../../../core/utils/result.dart';
import '../../data/repositories/tasks_repository_impl.dart';

class FetchTaskByIDUseCase {
  final TasksRepositoryImpl tasksRepositoryImpl;

  FetchTaskByIDUseCase({required this.tasksRepositoryImpl});

  Future<Result<void>> call(String id) async {
    return await tasksRepositoryImpl.fetchTaskByID(id);
  }
}
