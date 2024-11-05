import 'package:abm/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/result.dart';
import 'endpoints.dart';

class HttpsConsumer {
  final String baseUrl = EndPoints.baserUrl;

  Map<String, String> _generateHeaders([Map<String, String>? headers]) {
    return {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'authorization': "bearer ${preferences?.getString('token')}",
      ...?headers,
    };
  }

  Future<Result<http.Response>> _sendRequest(
    Future<http.Response> Function() request,
  ) async {
    try {
      final response = await request();
      if (response.statusCode == 200) {
        return Result(data: response);
      } else {
        return Result(error: 'Request failed: ${response.body}');
      }
    } catch (e) {
      return Result(error: e.toString());
    }
  }

  Future<Result<http.Response>> get({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    return _sendRequest(
      () => http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _generateHeaders(headers),
      ),
    );
  }

  Future<Result<http.Response>> post({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    return _sendRequest(
      () => http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _generateHeaders(headers),
        body: jsonEncode(body),
      ),
    );
  }

  Future<Result<http.Response>> put({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    return _sendRequest(
      () => http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: _generateHeaders(headers),
        body: jsonEncode(body),
      ),
    );
  }

  Future<Result<http.Response>> delete({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    return _sendRequest(
      () => http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: _generateHeaders(headers),
      ),
    );
  }

  Future<Result<http.StreamedResponse>> multipartPost({
    required String endpoint,
    required Map<String, String> fields,
    required String fileKey,
    required List<http.MultipartFile> files,
    required bool isProfile,
    Map<String, String>? headers,
  }) async {
    try {
      final request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl$endpoint'))
            ..headers.addAll(_generateHeaders(headers))
            ..fields.addAll(fields);
      for (http.MultipartFile file in files) {
        request.files.add(file);
      }

      final streamedResponse = await request.send();
      if (isProfile) {
        if (streamedResponse.statusCode == 200) {
          return Result(data: streamedResponse);
        } else {
          final response = await http.Response.fromStream(streamedResponse);
          return Result(error: 'Request failed: ${response.body}');
        }
      } else {
        if (streamedResponse.statusCode == 201) {
          return Result(data: streamedResponse);
        } else {
          final response = await http.Response.fromStream(streamedResponse);
          return Result(error: 'Request failed: ${response.body}');
        }
      }
    } catch (e) {
      return Result(error: e.toString());
    }
  }
}
