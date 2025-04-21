import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';


class ImageUploader {
  final Dio _dio = Dio();

  // Compress image
  Future<File> compressImage(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image == null) {
        print('Failed to decode image: ${imageFile.path}');
        return imageFile;
      }
      final compressed = img.encodeJpg(image, quality: 85); // Adjust quality (0-100)
      final tempDir = Directory.systemTemp;
      final tempFile = File('${tempDir.path}/${imageFile.path.split('/').last}.compressed.jpg');
      await tempFile.writeAsBytes(compressed);
      print('Compressed image: ${imageFile.path} -> ${tempFile.lengthSync()} bytes');
      return tempFile;
    } catch (e) {
      print('Error compressing image: $e');
      return imageFile;
    }
  }

  // Encode image to Base64
  Future<String> encodeImageFileToBase64(File imageFile) async {
    try {
      final imageBytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(imageBytes);
      print('Encoded image to Base64: ${imageFile.path}, length=${base64Image.length}');
      return base64Image;
    } catch (e) {
      print('Error encoding image to Base64: $e');
      return '';
    }
  }

  // Upload image as Base64 using Dio
  Future<String?> uploadImage(BuildContext context, File imageFile) async {
    print('Uploading image: ${imageFile.path}');

    try {
      // Compress image
      final compressedFile = await compressImage(imageFile);

      // Encode to Base64
      final base64Image = await encodeImageFileToBase64(compressedFile);
      if (base64Image.isEmpty) {
        print('Failed to encode image to Base64');
        if (context.mounted) {
          showAlertDialog(context, 'Failed to encode image');
        }
        return null;
      }

      // Create JSON payload
      final payload = {
        'file': base64Image,
        'token': SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ?? '',
        'app': 'in.tsnpdcl.npdclemployee',
        'apiKey': Apis.API_KEY, // From Java FileUploaderWithToken
      };
      print('Image upload payload: ${payload.keys}');

      // Send request with Dio
      final response = await _dio.post(
        Apis.IMAGE_UPLOAD_URL,
        data: payload,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${payload['token']}',
            'X-API-Key': payload['apiKey'],
          },
        ),
      );

      print('Image upload response: status=${response.statusCode}, body=${response.data}');

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('message')) {
          print('Image uploaded successfully: ${jsonResponse['message']}');
          return jsonResponse['message']; // Image URL
        } else {
          print('Response does not contain message field');
          if (context.mounted) {
            showAlertDialog(context, 'Invalid response format');
          }
          return null;
        }
      } else {
        print('Image upload failed: status=${response.statusCode}, body=${response.data}');
        if (context.mounted) {
          showAlertDialog(context, 'Image upload failed: ${response.statusMessage}');
        }
        return null;
      }
    } catch (e, stackTrace) {
      print('Failed to upload image: $e');
      print('Stack trace: $stackTrace');
      if (context.mounted) {
        showAlertDialog(context, 'Failed to upload image: $e');
      }
      return null;
    }
  }
}