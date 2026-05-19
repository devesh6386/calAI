import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadHelper {
  /// Calls the FastAPI endpoint to upload an image.
  /// If the FastAPI server is not reachable or fails, it falls back to uploading
  /// directly to the Supabase storage bucket named `food-images`.
  static Future<String> uploadFoodImage(File imageFile) async {
    final supabase = Supabase.instance.client;
    final authToken = supabase.auth.currentSession?.accessToken;
    final userId = supabase.auth.currentUser?.id;

    if (authToken == null || userId == null) {
      throw Exception('User not authenticated');
    }

    final ext = imageFile.path.split('.').last.toLowerCase();
    final fileName = '$userId/${DateTime.now().millisecondsSinceEpoch}.$ext';

    // 1. Try to upload via FastAPI backend
    try {
      String baseUrl = 'http://localhost:8000';
      if (Platform.isAndroid) {
        baseUrl = 'http://10.0.2.2:8000';
      }

      final uri = Uri.parse('$baseUrl/upload/food-image');
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $authToken'
        ..files.add(await http.MultipartFile.fromPath(
          'file',
          imageFile.path,
          contentType: _contentTypeFromExtension(imageFile.path),
        ));

      final streamedResponse = await request.send().timeout(const Duration(seconds: 4));
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final body = response.body;
        final imageUrl = RegExp(r'"image_url"\s*:\s*"([^"]+)"')
            .firstMatch(body)
            ?.group(1);
        if (imageUrl != null) {
          return imageUrl;
        }
      }
    } catch (e) {
      // Print warning and proceed to Supabase fallback
      print('FastAPI upload failed, falling back to direct Supabase storage upload: $e');
    }

    // 2. Fallback: Upload directly to Supabase storage
    try {
      await supabase.storage.from('food-images').upload(
        fileName,
        imageFile,
        fileOptions: FileOptions(
          contentType: 'image/$ext',
          upsert: true,
        ),
      );
      return supabase.storage.from('food-images').getPublicUrl(fileName);
    } catch (e) {
      throw Exception('Upload failed both on FastAPI and direct Supabase: $e');
    }
  }

  // Simple helper to set mime‑type based on file extension
  static MediaType _contentTypeFromExtension(String path) {
    final ext = path.split('.').last.toLowerCase();
    switch (ext) {
      case 'png':
        return MediaType('image', 'png');
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'webp':
        return MediaType('image', 'webp');
      default:
        return MediaType('application', 'octet-stream');
    }
  }
}
