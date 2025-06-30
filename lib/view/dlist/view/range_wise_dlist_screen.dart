import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/dlist/model/dlist_meta_data.dart';

class RangeWiseDlistScreen extends StatefulWidget {
  static const id = Routes.rangeWiseDlistScreen;
  final String data;

  const RangeWiseDlistScreen({
    super.key,
    required this.data,
  });

  @override
  State<RangeWiseDlistScreen> createState() => _RangeWiseDlistScreenState();
}

class _RangeWiseDlistScreenState extends State<RangeWiseDlistScreen> {
  late DlistMetaData _dlistMetaData;

  @override
  void initState() {
    super.initState();
    _dlistMetaData = DlistMetaData.fromJson(jsonDecode(widget.data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          "Choose Range".toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: titleSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 16.0, // Horizontal space between items
            mainAxisSpacing: 16.0, // Vertical space between items
            childAspectRatio: 1.0, // Square items (1:1 ratio)
          ),
          itemCount: _dlistMetaData.rangesList!.length,
          itemBuilder: (context, index) {
            final item = _dlistMetaData.rangesList![index];
            return Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12.0),
                onTap: () {
                  var argument = {
                    "r": item.rangeCode,
                    "oc": _dlistMetaData.ofcCode,
                    "my": _dlistMetaData.monthYear,
                  };
                  Navigation.instance
                      .navigateTo(Routes.clusterMapScreen, args: argument);
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${item.rangeLabel}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: normalSize,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "(${item.count})",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: extraRegularSize,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
