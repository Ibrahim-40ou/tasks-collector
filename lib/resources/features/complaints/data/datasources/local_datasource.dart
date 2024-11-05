import '../../../../core/api/https_consumer.dart';
import '../../../../core/cache/database_helper.dart';
import '../../../../core/services/image_services.dart';
import '../../../../core/services/internet_services.dart';
import '../../data/models/complaint_model.dart';
import '../../domain/entities/complaint_entity.dart';

class LocalComplaintsDatasource {
  final DatabaseHelper databaseHelper;
  final ImageService imageService;
  final HttpsConsumer httpsConsumer;

  LocalComplaintsDatasource({
    required this.databaseHelper,
    required this.imageService,
    required this.httpsConsumer,
  });

  Future<List<ComplaintEntity>> fetchComplaints() async {
    return await databaseHelper.getAllComplaints();
  }

  Future<void> storeComplaints(List<ComplaintEntity> newComplaints) async {
    await databaseHelper.deleteAllComplaints();
    final List<ComplaintModel> complaintsToInsert = [];
    for (ComplaintEntity complaintEntity in newComplaints) {
      final complaint = ComplaintModel(
        id: complaintEntity.id,
        description: complaintEntity.description,
        address: complaintEntity.address,
        lat: complaintEntity.lat,
        lng: complaintEntity.lng,
        governorateId: complaintEntity.governorateId,
        date: complaintEntity.date,
        media: complaintEntity.media,
        statusId: complaintEntity.statusId,
      );
      List<String> localImagePaths = [];
      for (String imageUrl in complaint.media) {
        String localPath = await imageService.downloadImage(imageUrl);
        localImagePaths.add(localPath);
      }
      complaint.media = localImagePaths;
      complaintsToInsert.add(complaint);
    }
    for (ComplaintModel complaint in complaintsToInsert) {
      if (await ConnectionServices().isInternetAvailable()) {
        await databaseHelper.insertComplaint(complaint, 'uploaded');
      } else {
        await databaseHelper.insertComplaint(complaint, 'waiting');
      }
    }
    databaseHelper.printAllComplaints();
  }

  Future<void> addComplaint(ComplaintEntity complaint) async {
    if (await ConnectionServices().isInternetAvailable()) {
      await databaseHelper.insertComplaint(complaint, 'uploaded');
      databaseHelper.printAllComplaints();
    } else {
      await databaseHelper.insertComplaint(complaint, 'waiting');
      databaseHelper.printAllComplaints();
    }
  }

  Future<void> deleteComplaint(int id) async {
    await databaseHelper.markComplaintAsDeleted(id);
  }

  Future<void> deleteAllWaitingComplaints() async {
    await databaseHelper.deleteAllWaitingComplaints();
  }

  Future<void> deleteAllDeletedComplaints() async {
    await databaseHelper.deleteAllDeletedComplaints();
  }
}
