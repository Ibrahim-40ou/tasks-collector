import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../core/api/endpoints.dart';
import '../../../../core/api/https_consumer.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/complaint_entity.dart';
import '../models/complaint_model.dart';

class ComplaintsDatasource {
  final HttpsConsumer httpsConsumer;

  ComplaintsDatasource({required this.httpsConsumer});

  Future<Result<List<ComplaintEntity>>> fetchComplaints() async {
    late List<ComplaintEntity> complaints = [];
    final result = await httpsConsumer.get(
        endpoint: '${EndPoints.complaint}?include=media');
    if (result.isSuccess && result.data != null) {
      final responseBody = jsonDecode(result.data!.body);
      for (Map<String, dynamic> complaint in responseBody['data']) {
        complaints.add(ComplaintModel.fromJson(complaint));
      }
      return Result<List<ComplaintEntity>>(data: complaints);
    } else {
      return Result<List<ComplaintEntity>>(error: result.error);
    }
  }

  Future<Result<void>> addComplaint(ComplaintModel complaint) async {
    List<http.MultipartFile> files = [];
    final Map<String, String> fields = complaint.toJson();
    for (String path in complaint.media) {
      final file = File(path);
      files.add(
        await http.MultipartFile.fromPath(
          'media[]',
          file.path,
        ),
      );
    }
    final result = await httpsConsumer.multipartPost(
      endpoint: EndPoints.complaint,
      fields: fields,
      fileKey: 'media',
      files: files,
      isProfile: false,
    );
    if (result.data != null) {
      return Result<void>(data: null);
    } else {
      print(result.error);
      return Result<void>(error: result.error);
    }
  }

  Future<Result<void>> deleteComplaint(int  id) async {
    final result = await httpsConsumer.delete(
      endpoint: '${EndPoints.deleteComplaint}$id',
    );
    if(result.data != null && result.isSuccess) {
      return Result<void>(data: null);
    } else {
      return Result<void>(error: result.error);
    }
  }
}
