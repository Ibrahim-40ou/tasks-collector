import '../../../../core/utils/result.dart';
import '../../data/repositories/tasks_repository_impl.dart';

class PaginatedFetchUseCase {
  final TasksRepositoryImpl tasksRepositoryImpl;

  PaginatedFetchUseCase({required this.tasksRepositoryImpl});

  Future<Result<void>> call(int perPage) async {
    return await tasksRepositoryImpl.paginatedFetch(perPage);
  }
}
