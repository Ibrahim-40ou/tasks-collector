import '../../../../core/utils/result.dart';
import '../../data/repositories/complaints_repository_impl.dart';

class DeleteComplaintsUseCase {
  final ComplaintsRepositoryImpl complaintsRepositoryImpl;

  DeleteComplaintsUseCase({required this.complaintsRepositoryImpl});

  Future<Result<void>> call(int id) async {
    return await complaintsRepositoryImpl.deleteComplaint(id);
  }
}
