import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/viewmodel/issue_duplicate_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class IssueDuplicateReceipt extends StatelessWidget {
  static const id = Routes.issueDuplicateReceipt;
  const IssueDuplicateReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: const Text(
          'DUPLICATE PR',
          style: TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => IssueDuplicateReceiptViewModel(context: context),
        child: Consumer<IssueDuplicateReceiptViewModel>(
            builder: (context, viewModel, child) {
              return viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              :  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('ENTER USCNO :'),
                      TextField(
                          keyboardType: TextInputType.number,
                          controller: viewModel.uscnoController),
                      const SizedBox(height: 11),
                      const Align(
                        alignment: Alignment.center,
                        child: Text('(OR)',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 11),
                      const Text('ENTER SCNO :'),
                      TextField(controller: viewModel.scnoController),
                      const SizedBox(height: 11),
                      const Align(
                        alignment: Alignment.center,
                        child: Text('(OR)',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 11),
                      const Text('ENTER RECEIPT NO :'),
                      TextField(controller: viewModel.receiptNoController),
                      const SizedBox(height: 11),
                      SizedBox(
                        width: double.infinity,
                      child:PrimaryButton(
                          onPressed: () {
                            // viewModel.fetchDuplicateReceipt(context);
                          },
                          text: 'ISSUE DUPLICATE RECEIPT'),
                      ),
                    ]
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
