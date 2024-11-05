import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../../core/api/endpoints.dart';
import '../../../../core/api/https_consumer.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

class UserInformationDataSource {
  final HttpsConsumer httpsConsumer;

  UserInformationDataSource({
    required this.httpsConsumer,
  });

  Future<Result<UserEntity>> fetchCurrentUser() async {
    final result = await httpsConsumer.get(endpoint: EndPoints.me);
    if (result.isSuccess && result.data != null) {
      final responseBody = jsonDecode(result.data!.body);

      final user = UserModel.fromJson(responseBody);

      return Result<UserEntity>(data: user);
    } else {
      return Result<UserEntity>(error: result.error);
    }
  }

  Future<Result<void>> updateUserInformation({
    required String name,
    required String governorateId,
    required String filePath,
  }) async {
    final fields = {
      'name': name,
      'governorate_id': governorateId,
      '_method': 'PUT',
    };
    if (filePath.isNotEmpty && !filePath.contains('http')) {
      final file = File(filePath);
      final avatarFile = http.MultipartFile(
        'avatar',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: file.path.split('/').last,
      );

      final result = await httpsConsumer.multipartPost(
        endpoint: EndPoints.profile,
        fields: fields,
        fileKey: 'avatar',
        files: [avatarFile],
        isProfile: true,
      );
      if (result.data != null) {
        return Result<void>(data: null);
      } else {
        return Result<void>(error: result.error);
      }
    } else {
      final result = await httpsConsumer.post(
        endpoint: EndPoints.profile,
        body: fields,
      );
      if (result.data != null) {
        return Result<void>(data: null);
      } else {
        return Result<void>(error: result.error);
      }
    }
  }
}
