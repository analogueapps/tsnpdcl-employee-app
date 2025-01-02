import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';

class PinchZoomImageView extends StatelessWidget {
  static const id = Routes.pinchZoomImageView;
  final String imageUrl;

  const PinchZoomImageView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          clipBehavior: Clip.none, // Allows zooming beyond boundaries
          panEnabled: true, // Enables panning
          minScale: 1.0, // Minimum zoom scale
          maxScale: 4.0, // Maximum zoom scale
          child: Image.network(
            Apis.NPDCL_STORAGE_SERVER_IP+imageUrl,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.broken_image,
                size: 100,
                color: Colors.grey,
              );
            },
          ),
        ),
      ),
    );
  }
}
