
import '../../../../core/utils/result.dart';
import '../../domain/repositories/complaints_repository.dart';
import '../datasources/complaints_datasource.dart';
import '../models/complaint_model.dart';


class ComplaintsRepositoryImpl extends ComplaintsRepository {
  final ComplaintsDatasource complaintsDatasource;
  ComplaintsRepositoryImpl({required this.complaintsDatasource});
  @override
  Future<Result<void>> fetchComplaints() async {
    return await complaintsDatasource.fetchComplaints();
  }

  @override
  Future<Result<void>> addComplaint(ComplaintModel complaint) async {
    return await complaintsDatasource.addComplaint(complaint);
  }

  @override
  Future<Result<void>> deleteComplaint(int id) async {
    return await complaintsDatasource.deleteComplaint(id);
  }
}