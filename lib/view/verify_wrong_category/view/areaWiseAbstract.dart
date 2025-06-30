import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/verify_wrong_category/viewmodel/areaWiseAbstract_viewmodel.dart';

class AreaWiseAbstractView extends StatelessWidget {
  static const id = Routes.areaWiseAbstract;
  const AreaWiseAbstractView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: const Text(
            'Wrong Cat Confirmations',
            style: TextStyle(
                color: Colors.white,
                fontSize: titleSize,
                fontWeight: FontWeight.w700),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back))),
      body: ChangeNotifierProvider(
          create: (_) => AreaWiseAbstractViewModel(context: context),
          child: Consumer<AreaWiseAbstractViewModel>(
              builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                children: [
                  // TextField(
                  //   controller: viewModel.searchController,
                  //   decoration: const InputDecoration(
                  //       hintText: 'Find...',
                  //       prefixIcon: Icon(Icons.search_outlined)
                  //   ),
                  // ),
                  // SizedBox(height: 11,),
                  Expanded(
                    child: viewModel.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: viewModel.verifyWrongData.length,
                            itemBuilder: (context, index) {
                              final item = viewModel.verifyWrongData[index];
                              return InkWell(
                                onTap: () {},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text('${item.areaCode} - ${item.areaName}'),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total: ${item.totalCount}',
                                          style: const TextStyle(
                                              color: Colors.blue),
                                        ),
                                        Text(
                                          'Verified: ${item.verifiedCount}',
                                          style: const TextStyle(
                                              color: Colors.green),
                                        ),
                                        Text(
                                          'Pending: ${item.pendingCount}',
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              );
                            }),
                  )
                ],
              ),
            );
          })),
    );
  }
}
