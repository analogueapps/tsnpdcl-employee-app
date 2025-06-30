import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/gis_ids/model/gis_individual_model.dart';
import 'package:tsnpdcl_employee/view/gis_ids/viewModel/view_work_viewmodel.dart';

class WorkDetailsPage extends StatelessWidget {
  static const id = Routes.viewWorkScreen;
  const WorkDetailsPage(
      {super.key, required this.surveyID, required this.status});
  final int surveyID;
  final String status;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WorkDetailsViewModel(
          context: context, surId: surveyID, individualStatus: status),
      child:
          Consumer<WorkDetailsViewModel>(builder: (context, viewModel, child) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: const Text(
                'View Work Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: toolbarTitleSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.builder(
                itemCount: viewModel.workDetails.length,
                itemBuilder: (context, index) {
                  final data = viewModel.workDetails[index];
                  return data == null
                      ? const Center(child: Text("Please try again"))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Before Details
                            const SizedBox(height: 10),
                            const Text('MAINTENANCE DETAILS',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 8),
                            _buildTwoColumnTable(_getBeforeDetails(data)),

                            const SizedBox(height: 20),
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

                            const Text(
                              'BEFORE WORK DETAILS',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.network(
                                data.beforeImageUrl != null
                                    ? data.beforeImageUrl!
                                    : 'https://example.com/placeholder.jpg',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(Icons.broken_image,
                                        color: Colors.grey, size: 50),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 10),
                            const Text(
                              'BEFORE WORK. PHOTO',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 21),

                            // Proposed Details
                            data.status == 'PENDING'
                                ? _buildTwoColumnTable(
                                    _getPendingProposedDetails(data))
                                : _buildTwoColumnTable(
                                    _getProposedDetails(data)),

                            Visibility(
                                visible: data.status == "FINISHED",
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Image.network(
                                        data.afterImageUrl != null
                                            ? data.afterImageUrl!
                                            : 'https://example.com/placeholder.jpg',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Center(
                                            child: Icon(Icons.broken_image,
                                                color: Colors.grey, size: 50),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    _buildTwoColumnTable(
                                        _afterUploadDetails(data)),
                                  ],
                                ))
                          ],
                        );
                },
              ),
            ),
            floatingActionButton: Visibility(
              visible:
                  viewModel.workDetails.any((item) => item.status == "PENDING"),
              child: FloatingActionButton(
                onPressed: () {
                  Navigation.instance.navigateTo(
                      Routes.viewWorkFloatButtonScreen,
                      args: viewModel.workDetails[0].surveyId.toString());
                },
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(Icons.edit),
              ),
            ),
          ),
        );
      }),
    );
  }

  // Before Details (First Half)
  List<Map<String, String>> _getBeforeDetails(GisSurveyData work) {
    return [
      // {'label': 'Survey ID', 'value': work.surveyId.toString()},
      {'label': 'Work Description', 'value': work.workDescription ?? '-'},
      {'label': 'Status', 'value': work.status ?? '-'},
      {'label': 'SUBSTATION CODE', 'value': ''},
      {'label': '11KV Feeder Name', 'value': work.feederName ?? '-'},
      {'label': 'DTR SS NO', 'value': '-'},
      // {'label': 'Feeder Code', 'value': work.feederCode ?? '-'},
      {'label': 'POLE Type', 'value': work.lineType ?? '-'},
      {'label': 'Sanction No.', 'value': work.sanctionNo ?? '-'},
      // {'label': 'Circle', 'value': work.circle ?? '-'},
      // {'label': 'Division', 'value': work.division ?? '-'},
      // {'label': 'Subdivision', 'value': work.subdivision ?? '-'},
      // {'label': 'Section', 'value': work.section ?? '-'},
    ];
  }

  List<Map<String, String>> _getProposedDetails(GisSurveyData work) {
    return [
      {'label': 'Before Latitude', 'value': work.beforeLat?.toString() ?? '-'},
      {
        'label': 'Before Longitude',
        'value': work.pbeforeLon?.toString() ?? '-'
      },
      {'label': 'Uploaded By EMP ID', 'value': work.surveyorId.toString()},
      {
        'label': 'Date of Before Marked',
        'value': work.dateOfBeforeMarked ?? '-'
      },
      // {'label': 'SAP Upload Flag', 'value': work.sapUploadFlag ?? '-'},
      // {'label': 'Point Voltage', 'value': work.pointVoltage ?? '-'},
    ];
  }

  List<Map<String, String>> _getPendingProposedDetails(GisSurveyData work) {
    return [
      {'label': 'Before Latitude', 'value': work.beforeLat?.toString() ?? '-'},
      {
        'label': 'Before Longitude',
        'value': work.pbeforeLon?.toString() ?? '-'
      },
      {'label': 'Uploaded By EMP ID', 'value': work.surveyorId.toString()},
      {'label': 'Time of Survey', 'value': work.timeOfSurveyor ?? '-'},
      {
        'label': 'Date of Before Marked',
        'value': work.dateOfBeforeMarked ?? '-'
      },
      {'label': 'FINISHED DATE', 'value': ''},
      {'label': 'Remarks', 'value': work.remarksBySurveyor.toString() ?? '-'},
      {'label': 'MON/YEAR', 'value': work.monthYear.toString() ?? ''},
      {'label': 'Village Code', 'value': ''},
      // {'label': 'SAP Upload Flag', 'value': work.sapUploadFlag ?? '-'},
      // {'label': 'Point Voltage', 'value': work.pointVoltage ?? '-'},
    ];
  }

  List<Map<String, String>> _afterUploadDetails(GisSurveyData work) {
    return [
      {'label': 'After Latitude', 'value': work.afterLat?.toString() ?? '-'},
      {'label': 'After Longitude', 'value': work.afterLon?.toString() ?? '-'},
      {
        'label': 'Before work Date',
        'value': work.dateOfBeforeMarked.toString()
      },
      {'label': 'After work Date', 'value': work.dateOfAfterMarked.toString()},
      {'label': 'Remarks', 'value': work.remarksBySurveyor.toString() ?? ''},
      {'label': 'Purpose', 'value': ''},
      {'label': 'Village code', 'value': ''},
      {'label': 'Village name', 'value': ''},
      {'label': 'Defect Code', 'value': ''},
      {'label': 'Defect ', 'value': ''},
      {'label': 'EMP code of person present', 'value': ''},
      {'label': 'Npdcl emp name', 'value': ''},
      {'label': 'Designation', 'value': ''},
      {'label': 'Name of Panchayat Person', 'value': ''},
      {'label': 'Designation of Panchayat person', 'value': ''},
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
