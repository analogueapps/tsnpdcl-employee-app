import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/interruptions/viewmodel/saidi_saifi_calculator_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/month_year_selector.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class SaidiSaifiCalculatorScreen extends StatelessWidget {
  static const id = Routes.saidiSaifiCalculatorScreen;

  const SaidiSaifiCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SaidiSaifiCalculatorViewmodel(context: context),
      child: Consumer<SaidiSaifiCalculatorViewmodel>(
        builder: (context, viewmodel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                GlobalConstants.saidiSaifiCalculator.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: viewmodel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "SAIDI SAIFI CALCULATOR",
                            style: TextStyle(fontSize: extraTitleSize),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Select Month
                        const Text("Select Month",
                            style: TextStyle(fontSize: titleSize)),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MonthYearSelector(),
                                ),
                              );

                              if (result != null && result is Map) {
                                viewmodel.setSelectedMonthYear(
                                  result['month'] as String,
                                  result['year'] as int,
                                  context,
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  CommonColors.textFieldColor),
                              shape: WidgetStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero),
                              ),
                            ),
                            child: viewmodel.selectedMonthYear != null
                                ? Text(
                                    '${viewmodel.selectedMonthYear!['month']} ${viewmodel.selectedMonthYear!['year']}',
                                    style: const TextStyle(color: Colors.black),
                                  )
                                : const Text(
                                    'TAP HERE',
                                    style: TextStyle(color: Colors.black),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Only show these if month/year is selected
                        if (viewmodel.selectedMonthYear != null) ...[
                          // Select Substation with Dialog Popup
                          const Text("Select Substation",
                              style: TextStyle(fontSize: titleSize)),
                          const SizedBox(height: 10),

                          // Substation Selection Button with Down Arrow
                          GestureDetector(
                            onTap: viewmodel.substations.isNotEmpty
                                ? () {
                                    print(
                                        "Substations: ${viewmodel.substations}, ListSubStationItem: ${viewmodel.listSubStationItem}");
                                    _showSubstationDialog(context, viewmodel);
                                  }
                                : null,
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: CommonColors.textFieldColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    viewmodel.listSubStationSelectName ??
                                        "Select Substation",
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                          const Text("ENTER INTERRUPTION DETAILS"),
                          const SizedBox(height: 8),

                          if (viewmodel.listDistributionItem.isNotEmpty)
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Use parent scroll
                                shrinkWrap: true,
                                // Important!
                                itemCount:
                                    viewmodel.listDistributionItem.length,
                                itemBuilder: (context, index) {
                                  final data =
                                      viewmodel.listDistributionItem[index];
                                  final interruptionCtrl =
                                      viewmodel.interruptionControllers[index];
                                  final durationCtrl =
                                      viewmodel.durationControllers[index];

                                  void attachListeners() {
                                    void update() {
                                      viewmodel.updateInterruptionsData(
                                        feederCode: data.optionCode,
                                        ssCode: viewmodel.listSubStationSelect,
                                        elCount: interruptionCtrl
                                            .elInterruption.text,
                                        elDuration:
                                            durationCtrl.elDuration.text,
                                        olCount: interruptionCtrl
                                            .olInterruption.text,
                                        olDuration:
                                            durationCtrl.olDuration.text,
                                        elOlCount: interruptionCtrl
                                            .elOlInterruption.text,
                                        elOlDuration:
                                            durationCtrl.elOlDuration.text,
                                        lcCount: interruptionCtrl
                                            .lcInterruption.text,
                                        lcDuration:
                                            durationCtrl.lcDuration.text,
                                        bdCount: interruptionCtrl
                                            .bdInterruption.text,
                                        bdDuration:
                                            durationCtrl.bdDuration.text,
                                      );
                                    }

                                    for (final ctrl in [
                                      interruptionCtrl.elInterruption,
                                      interruptionCtrl.olInterruption,
                                      interruptionCtrl.elOlInterruption,
                                      interruptionCtrl.lcInterruption,
                                      interruptionCtrl.bdInterruption,
                                      durationCtrl.elDuration,
                                      durationCtrl.olDuration,
                                      durationCtrl.elOlDuration,
                                      durationCtrl.lcDuration,
                                      durationCtrl.bdDuration,
                                    ]) {
                                      ctrl.removeListener(
                                          update); // avoid duplicates
                                      ctrl.addListener(update);
                                    }
                                  }

                                  // Attach only once
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    attachListeners();
                                  });

                                  return Card(
                                    color: Colors.white,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 3),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(data.optionName),
                                          ),
                                          const SizedBox(height: 10),
                                          // _reusableLastRow("INTERRUPTION TYPE",
                                          //     "NO OF INTERRUPTIONS",
                                          //     "DURATION IN MINUTES"),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Expanded(
                                                child: Text(
                                                  "INTERRUPTION TYPE",
                                                  style: TextStyle(
                                                    fontSize: 10.5,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Container(
                                                width: 1,
                                                height: 50,
                                                margin:
                                                    const EdgeInsets.all(10),
                                                color: const Color(0xffcfcdcd),
                                              ),
                                              const Expanded(
                                                  child: Text(
                                                "NO OF\nINTERRUPTIONS",
                                                style: TextStyle(
                                                  fontSize: 10.5,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.start,
                                              )),
                                              const SizedBox(width: 10),
                                              Container(
                                                width: 1,
                                                height: 50,
                                                margin:
                                                    const EdgeInsets.all(10),
                                                color: const Color(0xffcfcdcd),
                                              ),
                                              const Expanded(
                                                child: Text(
                                                  "DURATION IN MINUTES",
                                                  style: TextStyle(
                                                    fontSize: 10.5,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ],
                                          ),
                                          _reusableLastRow(
                                              "EL",
                                              interruptionCtrl.elInterruption,
                                              durationCtrl.elDuration),
                                          _reusableLastRow(
                                              "OL",
                                              interruptionCtrl.olInterruption,
                                              durationCtrl.olDuration),
                                          _reusableLastRow(
                                              "EL & OL",
                                              interruptionCtrl.elOlInterruption,
                                              durationCtrl.elOlDuration),
                                          _reusableLastRow(
                                              "L.C",
                                              interruptionCtrl.lcInterruption,
                                              durationCtrl.lcDuration),
                                          _reusableLastRow(
                                              "Break Down",
                                              interruptionCtrl.bdInterruption,
                                              durationCtrl.bdDuration),
                                        ],
                                      ),
                                    ),
                                  );
                                }),

                          const SizedBox(height: 20),

                          // Calculate Button - Fixed to always provide a non-null VoidCallback
                          PrimaryButton(
                            text: "CALCULATE",
                            onPressed: () {
                              // Handle calculation logic here
                              print("Calculate pressed");
                              viewmodel.submitForm();
                            },
                            fullWidth: true,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                if (viewmodel.isLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showSubstationDialog(
      BuildContext context, SaidiSaifiCalculatorViewmodel viewmodel) {
    final TextEditingController searchController = TextEditingController();
    String searchQuery = '';

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Select Substation'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Search Field (keep existing)
                    TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        labelText: "Search Substation",
                        hintText: "Type to search",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    // Updated Substation List using listSubStationItem
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: viewmodel.listSubStationItem
                            .where((item) => item.optionName!
                                .toLowerCase()
                                .contains(searchQuery))
                            .length,
                        itemBuilder: (context, index) {
                          final filteredItems = viewmodel.listSubStationItem
                              .where((item) => item.optionName!
                                  .toLowerCase()
                                  .contains(searchQuery))
                              .toList();
                          // Extract only the substation name (e.g., "NAKKALAGUTTA" from "0003-33KV SS-NAKKALAGUTTA")
                          String fullName =
                              filteredItems[index].optionName ?? '';
                          String displayName = fullName.split('-').length > 2
                              ? fullName.split('-')[2].trim()
                              : fullName;

                          return ListTile(
                            title: Text(displayName),
                            onTap: () {
                              viewmodel.onListSubStationItemSelect(
                                  filteredItems[index].optionCode ?? '',
                                  filteredItems[index].optionName ?? '');
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((_) {
      searchController.dispose();
    });
  }

  Widget _reusableLastRow(
      String label, TextEditingController value, TextEditingController value2) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: 1,
            height: 50,
            margin: const EdgeInsets.all(10),
          ),
          Expanded(
              child: TextField(
            controller: value,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            ),
          )),
          const SizedBox(width: 10),
          Container(
            width: 1,
            height: 50,
            margin: const EdgeInsets.all(10),
          ),
          Expanded(
            child: TextField(
              controller: value2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
