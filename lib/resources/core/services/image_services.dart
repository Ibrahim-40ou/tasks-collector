import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  Future<String> downloadImage(String url) async {
    final directory = await getTemporaryDirectory();
    final filePath = join(directory.path, basename(url));

    if (await File(filePath).exists()) {
      return filePath;
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } else {
      throw Exception('Failed to download image');
    }
  }
}
