import 'package:abm/resources/features/complaints/data/models/complaint_model.dart';

import '../../../../core/utils/result.dart';
import '../../data/repositories/complaints_repository_impl.dart';

class AddComplaintUseCase {
  final ComplaintsRepositoryImpl complaintsRepositoryImpl;

  AddComplaintUseCase({required this.complaintsRepositoryImpl});

  Future<Result<void>> call(ComplaintModel complaint) async {
    return await complaintsRepositoryImpl.addComplaint(complaint);
  }
}
