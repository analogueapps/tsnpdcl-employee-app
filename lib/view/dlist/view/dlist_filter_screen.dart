import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/dlist/viewmodel/dlist_filter_viewmodel.dart';

class DlistFilterScreen extends StatelessWidget {
  static const id = Routes.dlistFilterScreen;
  final Map<String, dynamic> data;

  const DlistFilterScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DlistFilterViewmodel(context: context, data: data),
      child: Consumer<DlistFilterViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                "Configure Filter".toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: toolbarTitleSize,
                    fontWeight: FontWeight.w700
                ),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(doubleTen),
              child: Column(
                children: [
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Set Dlist Amount Range", // Replace with localization if needed
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Visibility(
                            visible: false,
                            child: CheckboxListTile(
                              title: const Text("All amount range"),
                              value: false,
                              onChanged: (val) {},
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Amount From"),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      height: 45,
                                      child: TextField(
                                        controller: viewModel.fromAmountController,
                                        decoration: const InputDecoration(
                                          hintText: "0",
                                          border: OutlineInputBorder(),
                                          isDense: true,
                                        ),
                                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Amount To"),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      height: 45,
                                      child: TextField(
                                        controller: viewModel.toAmountController,
                                        decoration: const InputDecoration(
                                          hintText: "999999999",
                                          border: OutlineInputBorder(),
                                          isDense: true,
                                        ),
                                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(top: 8),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Select Service Type",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    const Icon(Icons.place, color: Colors.red),
                                    Checkbox(
                                      value: viewModel.isLiveChecked,
                                      onChanged: (value) {
                                        viewModel.isLiveChecked = value!;
                                        viewModel.notifyListeners();
                                      },
                                    ),
                                    const Flexible(child: Text("Live")),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    const Icon(Icons.place, color: Colors.orange),
                                    Checkbox(
                                      value: viewModel.isUdcChecked,
                                      onChanged: (value) {
                                        viewModel.isUdcChecked = value!;
                                        viewModel.notifyListeners();
                                      },
                                    ),
                                    const Flexible(child: Text("UDC")),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    const Icon(Icons.place, color: Colors.blue),
                                    Checkbox(
                                      value: viewModel.isBillStopChecked,
                                      onChanged: (value) {
                                        viewModel.isBillStopChecked = value!;
                                        viewModel.notifyListeners();
                                      },
                                    ),
                                    const Flexible(child: Text("Bill Stop")),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(top: 8),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Choose Distribution",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: viewModel.filteredOptionList.length,
                            itemBuilder: (context, index) {
                              final item = viewModel.filteredOptionList[index];
                              return ListTile(
                                title: Text("${item.optionName} | ${item.optionId}"),
                                //trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  viewModel.itemClicked(item);
                                },
                              );
                            },
                            separatorBuilder: (_, __) => Divider(
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
