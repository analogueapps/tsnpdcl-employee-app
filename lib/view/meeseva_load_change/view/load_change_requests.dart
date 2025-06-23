import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/meeseva_load_change/viewmodel/load_change_request_viewmodel.dart';

class LoadChangeRequests extends StatelessWidget {
  static const id = Routes.loadChangeRequests;
  const LoadChangeRequests({super.key, required this.statusData});

  final Map<String, dynamic> statusData;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LoadChangeRequestViewmodel(context: context,data:statusData),
        child: Consumer<LoadChangeRequestViewmodel>(
        builder: (context, viewModel, child)
    {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Load Change Requests", style: TextStyle(
                    color: Colors.white,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700),),
                Text(viewModel.getStatusText(statusData['status']),
                  style: TextStyle(
                    color: Colors.white,),),
              ]
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Stack(
            children:[
              ListView.builder(
                  itemCount: viewModel.openList.length,
                  itemBuilder: (context, index) {
                    final data = viewModel.openList[index];
                    return data == null
                        ?
                    const Center(child: Text("No data found")) :


                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        // Optional: to give rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(
                                0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all( 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(data.regNum),
                                        Text( DateFormat('dd/MM/yyyy').format(DateTime.parse(data.insDate as String)),  style: TextStyle(color: Colors.grey[600]),)
                                      ],),

                                    Text(data.consumerName, style: TextStyle(color: Colors.grey[600]),),
                                    Text("${data.existCat} -> ${data.reqCat}"??"",  style: TextStyle(color: Colors.red),),
                                    Text(data.status??"",  style: TextStyle(color: Colors.teal),),
                                  ],
                                ),
                              ),
                              // IconButton with no space between it and the text
                              IconButton(
                                onPressed: () {
                                  var arguments={
                                    'status':statusData['status'],
                                    'catData':jsonEncode(
                                        data.toJson()),
                                  };
                                  Navigation.instance
                                      .navigateTo(Routes.loadChangeDetail, args: arguments);
                                },
                                icon:
                                const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                                padding:
                                EdgeInsets.zero, // Ensures there is no extra padding
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
              ),
              if (viewModel.isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.3), // Optional: dim background
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ]
        ),
      );
    }
    )
    );
  }
  //LoadChangeRequestsListActivity class
}
