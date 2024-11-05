import '../../data/models/complaint_model.dart';

abstract class ComplaintsRepository {
  Future<void> fetchComplaints();
  Future<void> addComplaint(ComplaintModel complaint);
  Future<void> deleteComplaint(int id);
}