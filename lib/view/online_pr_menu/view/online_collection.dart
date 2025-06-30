import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/viewmodel/online_collection_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class OnlineCollectionView extends StatelessWidget {
  static const id = Routes.onlineCollection;
  const OnlineCollectionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: const Text(
          'ONLINE PR',
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
          create: (_) => OnlineCollectionViewModel(context: context),
          child: Consumer<OnlineCollectionViewModel>(
              builder: (context, viewModel, child) {
            return viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(11),
                    child: Column(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(11),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'ENTER USCNO :',
                                  style: TextStyle(fontSize: 16),
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: viewModel.uscnoController,
                                  onChanged: (String value) {
                                    viewModel.uscnoController.text = value;
                                  },
                                ),
                                const SizedBox(height: 11),
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '(OR)',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                const SizedBox(height: 11),
                                const Text(
                                  'ENTER SCNO :',
                                  style: TextStyle(fontSize: 16),
                                ),
                                TextField(
                                  controller: viewModel.scnoController,
                                  onChanged: (String value) {
                                    viewModel.scnoController.text = value;
                                  },
                                ),
                                const SizedBox(height: 11),
                                SizedBox(
                                  width: double.infinity,
                                  child: PrimaryButton(
                                      onPressed: () {
                                        // fetchBillDetails('123456') api call
                                      },
                                      text: 'GET BILL DETAILS'),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 11),
                        // Display Bill Details
                        Card(
                            child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(11.0),
                              child: Text(
                                'BILL DETAILS',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(11),
                              child: Column(
                                children: [
                                  billDetails("NAME", "-"),
                                  billDetails("USCNO", "-"),
                                  billDetails("SCNO", "-"),
                                  billDetails("BILL DATE", "-"),
                                  billDetails("DUE DATE", "-"),
                                  billDetails("DISCO. DATE", "-"),
                                  billDetails("CC AMT", "-"),
                                  billDetails("ARR AMT", "-"),
                                  billDetails("TOTAL BILL AMT", "-"),
                                  const SizedBox(
                                    height: 11,
                                  ),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'INCLUDE ACD AMT',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: "YES",
                                        groupValue: viewModel.includeRcAmount,
                                        onChanged: viewModel.setIncludeRcAmount,
                                      ),
                                      const Text("YES"),
                                      const SizedBox(
                                        width: 100,
                                      ),
                                      Radio(
                                        value: "NO",
                                        groupValue: viewModel.includeRcAmount,
                                        onChanged: viewModel.setIncludeRcAmount,
                                      ),
                                      const Text("NO"),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                  const SizedBox(
                                    height: 11,
                                  ),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'INCLUDE RC AMT',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: "YES",
                                        groupValue: viewModel.includeRcAmount,
                                        onChanged: viewModel.setIncludeRcAmount,
                                      ),
                                      const Text("YES"),
                                      const SizedBox(
                                        width: 100,
                                      ),
                                      Radio(
                                        value: "NO",
                                        groupValue: viewModel.includeRcAmount,
                                        onChanged: viewModel.setIncludeRcAmount,
                                      ),
                                      const Text("NO"),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                  const SizedBox(
                                    height: 11,
                                  ),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'ENTER AMOUNT EXCLUDING RC (if any)',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 11,
                                  ),
                                  const TextField(
                                    decoration: InputDecoration(
                                        label: Text('0.0'),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black))),
                                  ),
                                  const Divider(),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'RC AMT',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 0.3,
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'ACD AMT',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 0.3,
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'TOTAL AMOUNT',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 0.3,
                                  ),
                                  const SizedBox(
                                    height: doubleTen,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: PrimaryButton(
                                      onPressed: () {},
                                      // => viewModel.submitReceipt(context),
                                      text: "GENERATE RECEIPT",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))
                      ],
                    ),
                  );
          })),
    );
  }

  Widget billDetails(String label, String value) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value == "" ? "-" : value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      const Divider(),
      const SizedBox(
        height: doubleFive,
      )
    ]);
  }
}
