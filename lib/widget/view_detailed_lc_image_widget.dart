import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';


class ViewDetailedLcImageWidget extends StatelessWidget {
  final String imageUrl;

  const ViewDetailedLcImageWidget({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: doubleFour,
      margin: const EdgeInsets.all(doubleTwenty),
      child: Stack(
        children: [
          Image.network(
            Apis.NPDCL_STORAGE_SERVER_IP + imageUrl,
            fit: BoxFit.cover,
            height: doubleTwoHundred,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                height: doubleTwoHundred,
                width: double.infinity,
                child: const Center(
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                    size: doubleFifty,
                  ),
                ),
              );
            },
          ),
          Visibility(
            visible: imageUrl != "N/A",
            child: Positioned(
              bottom: doubleTen,
              right: doubleTen,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(pointSeven),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigation.instance.navigateTo(Routes.pinchZoomImageView, args: imageUrl);
                  },
                  icon: const Icon(Icons.fullscreen, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
