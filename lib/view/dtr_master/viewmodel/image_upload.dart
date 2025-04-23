import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';

class ImageUploader {
  final Dio _dio = Dio();

  Future<bool> isNetworkAvailable() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<img.Image?> _decodeImage(File file) async {
    try {
      final bytes = await file.readAsBytes();
      return img.decodeImage(bytes);
    } catch (_) {
      return null;
    }
  }

  Future<File> compressImage(File file, {int quality = 85}) async {
    try {
      final decodedImage = await _decodeImage(file);
      if (decodedImage == null) return file;

      final compressed = img.encodeJpg(decodedImage, quality: quality);
      final tempDir = Directory.systemTemp;
      final compressedFile = File('${tempDir.path}/${file.uri.pathSegments.last}.compressed.jpg');
      await compressedFile.writeAsBytes(compressed);
      return compressedFile;
    } catch (_) {
      return file;
    }
  }

  Future<String?> uploadImage(BuildContext context, File imageFile) async {
    print("Uploading image: ${imageFile.path}");

    if (!(await isNetworkAvailable())) {
      if (context.mounted) {
        AlertUtils.showSnackBar(context, "Please check your internet connection!", true);
      }
      return null;
    }

    try {
      final compressedFile = await compressImage(imageFile);

      final authToken = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ?? '';
      const apkName = 'in.tsnpdcl.npdclemployee';
      const apiKey = Apis.API_KEY;

      final headers = {
        'Content-Type': 'image/jpeg',
        'filename': 'ImageFile',
        'token': authToken,
        'apk': apkName,
        'api': apiKey,
        'Connection': 'Keep-Alive',
      };

      final fileBytes = await compressedFile.readAsBytes();

      final response = await _dio.post(
        Apis.IMAGE_UPLOAD_URL,
        data: Stream.fromIterable([fileBytes]),
        options: Options(
          headers: headers,
          contentType: 'image/jpeg',
          responseType: ResponseType.json,
        ),
      );

      print("Image upload status: ${response.statusCode}");
      print("Response body: ${response.data}");

      if (response.statusCode == 200) {
        final json = response.data;
        if (json is Map<String, dynamic> && json.containsKey('message')) {
          print("Upload success: ${json['message']}");
          return json['message'];
        } else {
          if (context.mounted) {
            AlertUtils.showSnackBar(context, 'Invalid response format', true);
          }
          return null;
        }
      } else {
        if (context.mounted) {
          AlertUtils.showSnackBar(context, 'Upload failed: ${response.statusMessage}', true);
        }
        return null;
      }
    } catch (e, st) {
      print("Exception: $e\n$st");
      if (context.mounted) {
        AlertUtils.showSnackBar(context, 'Failed to upload image', true);
      }
      return null;
    }
  }
}


