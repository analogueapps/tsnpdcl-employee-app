import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/viewmodel/new_proposal_viewmodel.dart';

class NewProposalScreen extends StatelessWidget {
  static const id = Routes.newProposalScreen;
  final String ssc;

  const NewProposalScreen({
    super.key,
    required this.ssc,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewProposalViewmodel(context: context, ssc: ssc),
      child: Consumer<NewProposalViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                "Create/select proposal".toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: toolbarTitleSize,
                    fontWeight: FontWeight.w700),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.allProposalList.isEmpty
                    ? const Center(
                        child: Text("No data founded."),
                      )
                    : ListView.builder(
                        itemCount: viewModel.allProposalList.length,
                        itemBuilder: (context, index) {
                          final item = viewModel.allProposalList[index];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: doubleTen, right: doubleTen),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: doubleFive,
                                    ),
                                    Text(
                                      "Proposal No. ${item.id}",
                                    ),
                                    const SizedBox(
                                      height: doubleFive,
                                    ),
                                    Text(
                                      checkNull(item.proposalDesc),
                                    ),
                                    const SizedBox(
                                      height: doubleTen,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            checkNull(item.ssName),
                                            style: const TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            checkNull(item.insertDate),
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                              color: Colors.purple,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: doubleTen,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              CommonColors.colorPrimary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(
                                              context, json.encode(item));
                                        },
                                        child: Text(
                                          "Select".toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: doubleFive,
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                                height: 1,
                              ),
                            ],
                          );
                        }),
          );
        },
      ),
    );
  }
}
