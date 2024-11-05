
import '../../../../core/utils/result.dart';
import '../../data/repositories/complaints_repository_impl.dart';

class FetchComplaintsUseCase {
  final ComplaintsRepositoryImpl complaintsRepositoryImpl;

  FetchComplaintsUseCase({required this.complaintsRepositoryImpl});

  Future<Result<void>> call() async {
    return await complaintsRepositoryImpl.fetchComplaints();
  }
}
