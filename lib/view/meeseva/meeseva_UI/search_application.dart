import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/view/meeseva/meeseva_UI/showDialog_gps.dart';

class SearchApplication extends StatefulWidget {
  final String regNo;

  const SearchApplication({super.key, required this.regNo});

  @override
  State<SearchApplication> createState() => _SearchApplicationState();
}

class _SearchApplicationState extends State<SearchApplication> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showGPSPermissionDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> consumerDetailsMap = {
      "SURENAME": "MOHAMMED",
      "NAME": "DILAWAR ASIF ALI"
    };
    Map<String, String> applicationDetailsMAP = {
      "APPLICATION ID": "123",
      "APPLICATION DATE": "12 Oct 2022 16:48:39"
    };
    Map<String, String> omStaffApplicarionMap = {
      "O&M STAFF ": "B.SHAILENDER REDDY,LM",
      "ALLOTMENT DATE": "14 Oct 2022 12:51:44"
    };
    Map<String, String> feasibilityMap = {
      "FEASIBILITY BY LM": "FEASIBLE",
      "FEASIBILITY BY AE": "FEASIBLE"
    };
    Map<String, String> supplyFeedingDetails = {
      "SUBSTATION": "0005-33KV SS-SHAYAMPET",
      "FEEDER CODE": "0005-11KV VANAVIGNANII"
    };
    Map<String, String> consumerReadinessReportMap = {
      "FEASIBILITY BY LM": "FEASIBLE",
      "FEASIBILITY BY AE": "FEASIBLE"
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.regNo,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.folder_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey.shade300),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Consumer Details'),
              ),
            ),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(
                  Icons.photo_library,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
            Table(
              border: TableBorder(
                horizontalInside:
                    BorderSide(color: Colors.grey.shade400, width: 1),
                verticalInside:
                    BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
              },
              children: [
                ...consumerDetailsMap.entries.map((entry) {
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          entry.key,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          entry.value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey.shade300),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('APPLICATION DETAILS'),
              ),
            ),
            Table(
              border: TableBorder(
                horizontalInside:
                    BorderSide(color: Colors.grey.shade400, width: 1),
                verticalInside:
                    BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
              },
              children: [
                ...applicationDetailsMAP.entries.map((entry) {
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          entry.key,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          entry.value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey.shade300),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('O&M STAFF ALLOTMENT'),
              ),
            ),
            Table(
              border: TableBorder(
                horizontalInside:
                    BorderSide(color: Colors.grey.shade400, width: 1),
                verticalInside:
                    BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
              },
              children: [
                ...omStaffApplicarionMap.entries.map((entry) {
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          entry.key,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          entry.value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey.shade300),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('FEASIBILITY'),
              ),
            ),
            Table(
              border: TableBorder(
                horizontalInside:
                    BorderSide(color: Colors.grey.shade400, width: 1),
                verticalInside:
                    BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
              },
              children: [
                ...feasibilityMap.entries.map((entry) {
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          entry.key,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          entry.value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey.shade300),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('SUPPLY FEEDING DETAIS'),
              ),
            ),
            Table(
              border: TableBorder(
                horizontalInside:
                    BorderSide(color: Colors.grey.shade400, width: 1),
                verticalInside:
                    BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
              },
              children: [
                ...supplyFeedingDetails.entries.map((entry) {
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          entry.key,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          entry.value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey.shade300),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('CONSUMER READINESS REPORT'),
              ),
            ),
            Table(
              border: TableBorder(
                horizontalInside:
                    BorderSide(color: Colors.grey.shade400, width: 1),
                verticalInside:
                    BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
              },
              children: [
                ...consumerReadinessReportMap.entries.map((entry) {
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          entry.key,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          entry.value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          )),
    );
  }
}
