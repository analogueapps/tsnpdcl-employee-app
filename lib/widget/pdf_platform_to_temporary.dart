import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class PdfPlatformToTemp{
  static Future<File> createTempFileFromPlatformFile(PlatformFile file) async {
    // Get temp directory
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/upload_${file.name}');

    // Write bytes to file
    if (file.bytes != null) {
      await tempFile.writeAsBytes(file.bytes!);
    } else if (file.path != null) {
      // Copy from path if bytes are not available
      await File(file.path!).copy(tempFile.path);
    } else {
      throw Exception("No file data available");
    }

    return tempFile;
  }

  /// Gets the display name of the file (from PlatformFile)
  static String getFileName(PlatformFile file) {
    return file.name;
  }
}