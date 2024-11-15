import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../core/api/endpoints.dart';
import '../../../../core/api/https_consumer.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/task_entity.dart';
import '../models/task_model.dart';

class TasksDatasource {
  final HttpsConsumer httpsConsumer;

  TasksDatasource({required this.httpsConsumer});

  Future<Result<List<TaskEntity>>> fetchTasks() async {
    late List<TaskEntity> tasks = [];
    final result = await httpsConsumer.get(
        endpoint: '${EndPoints.complaint}?include=media');
    if (result.isSuccess && result.data != null) {
      final responseBody = jsonDecode(result.data!.body);
      for (Map<String, dynamic> task in responseBody['data']) {
        tasks.add(TaskModel.fromJson(task));
      }
      return Result<List<TaskEntity>>(data: tasks);
    } else {
      return Result<List<TaskEntity>>(error: result.error);
    }
  }

  Future<Result<TaskEntity>> fetchTaskByID(String id) async {
    late TaskEntity task;
    final result = await httpsConsumer.get(
        endpoint: '${EndPoints.complaint}/$id?include=media');
    if (result.isSuccess && result.data != null) {
      final responseBody = jsonDecode(result.data!.body);
      task = TaskModel.fromJson(responseBody);
      return Result<TaskEntity>(data: task);
    } else {
      return Result<TaskEntity>(error: result.error);
    }
  }

  Future<Result<List<TaskEntity>>> paginatedFetch(int perPage) async {
    late List<TaskEntity> tasks = [];
    final result = await httpsConsumer.get(
        endpoint: '${EndPoints.perPage}$perPage&include=media');
    if (result.isSuccess && result.data != null) {
      final responseBody = jsonDecode(result.data!.body);
      for (Map<String, dynamic> task in responseBody['data']) {
        tasks.add(TaskModel.fromJson(task));
      }
      return Result<List<TaskEntity>>(data: tasks);
    } else {
      return Result<List<TaskEntity>>(error: result.error);
    }
  }

  Future<Result<void>> addTask(TaskModel task) async {
    List<http.MultipartFile> files = [];
    final Map<String, String> fields = task.toJson();
    for (String path in task.media) {
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
      return Result<void>(error: result.error);
    }
  }

  Future<Result<void>> deleteTask(int id) async {
    final result = await httpsConsumer.delete(
      endpoint: '${EndPoints.deleteComplaint}$id',
    );
    if (result.data != null && result.isSuccess) {
      return Result<void>(data: null);
    } else {
      return Result<void>(error: result.error);
    }
  }
}
