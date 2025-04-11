import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/gis_ids/model/gis_individual_model.dart';
import 'package:tsnpdcl_employee/view/gis_ids/viewModel/view_work_viewmodel.dart';


class WorkDetailsPage extends StatelessWidget {
  static const id = Routes.viewWorkScreen;
  const WorkDetailsPage({super.key, required this.workDetails});
  final List<GisSurveyData> workDetails;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WorkDetailsViewModel(context: context),
      child: WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: const Text('View Work Details',
            style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700,
            ),),
          leading: Consumer<WorkDetailsViewModel>(
            builder: (context, viewModel, child) => IconButton(
              icon: const Icon(Icons.close, color: Colors.white,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Before Details
                _buildTwoColumnTable(_getBeforeDetails(workDetails.first)),
                // Proposed Details Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: Colors.grey.shade300,
                  child: const Text(
                    'NOW PROPOSED DETAILS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 11),
                // Image
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // child: CachedNetworkImage(
                  //   imageUrl: workDetails.first.beforeImageUrl ?? '',
                  //   placeholder: (context, url) => const Center(child: Icon(Icons.image, size: 50)),
                  //   errorWidget: (context, url, error) => const Center(child: Icon(Icons.broken_image, size: 50)),
                  //   fit: BoxFit.cover,
                  // ),
                  child:Image.network(
                    workDetails.first.beforeImageUrl != null
                        ? Apis.NPDCL_STORAGE_SERVER_IP + workDetails.first.beforeImageUrl!
                        : 'https://example.com/placeholder.jpg',
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
                ),
                const SizedBox(height: 10),
                const Text(
                  'PHOTO',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 21),
                // Proposed Details
                _buildTwoColumnTable(_getProposedDetails(workDetails.first)),
              ],
            ),
          ),
        ),
        floatingActionButton: Consumer<WorkDetailsViewModel>(
          builder: (context, viewModel, child) => FloatingActionButton(
            onPressed: () {
              print("workDetails: ${workDetails.map((work) => work.toJson()).toList()}");
              Navigation.instance.navigateTo(Routes.viewWorkFloatButtonScreen);
            },
            child: const Icon(Icons.edit),
            backgroundColor: Colors.pinkAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      ),
    );
  }

  // Before Details (First Half)
  List<Map<String, String>> _getBeforeDetails(GisSurveyData work) {
    return [
      {'label': 'Work Description', 'value': work.workDescription ?? ''},
      {'label': 'Status', 'value': work.status ?? ''},
      {'label': 'SUBSTATION  CODE', 'value':  ''},
      {'label': '11KV Feeder Name', 'value': work.feederName ?? ''},
      {'label': 'DTR SS NO', 'value':  ''},
      {'label': 'Pole Type', 'value': work.lineType ?? ''},
      {'label': 'Sanction No.', 'value': work.sanctionNo ?? '-'},

    ];
  }

  // Proposed Details (Second Half)
  List<Map<String, String>> _getProposedDetails(GisSurveyData work) {
    return [
      {'label': 'Before Latitude', 'value': work.beforeLat?.toString() ?? ''},
      {'label': 'Before Longitude', 'value': work.pbeforeLon?.toString() ?? ''},
      // {'label': 'Substation Code', 'value': ''}, // Placeholder, no equivalent field
      // {'label': 'DTR SS No', 'value': ''}, // Placeholder, no equivalent field
      {'label': 'Uploaded By Emp ID', 'value': work.surveyorId ?? ''},
      {'label': 'Date of Upload', 'value': work.timeOfSurveyor ?? ''},
      {'label': 'Captured Date', 'value': work.dateOfBeforeMarked ?? ''},
      {'label': 'FINISHED DATE', 'value':  ''},
      {'label': 'REMARKS', 'value':  ''},
      {'label': 'Month Year', 'value': work.monthYear ?? ''},
      {'label': 'VILLAGE CODE ', 'value':  ''},
    ];
  }

  Widget _buildTwoColumnTable(List<Map<String, String>> data) {
    return Table(
      border: TableBorder(
        horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1),
        verticalInside: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
      },
      children: data.map((item) {
        return TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item['label'] ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
                softWrap: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item['value'] ?? '',
                softWrap: true,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}