import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/dismantle_of_service/viewmodel/dismantle_create_correspondence_viewmodel.dart';
import 'package:tsnpdcl_employee/view/routed_from_ccc/viewmodel/revoke_of_services_viewmodel.dart';
import 'package:tsnpdcl_employee/view/wrong_billing/viewmodel/app_billing_components_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class DismantleCreateCorrespondence extends StatelessWidget {
  static const id = Routes.dismantleCreateCorrespondence;

  const DismantleCreateCorrespondence({super.key, this.args});

  final Map<String, dynamic>? args;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: const Text(
          "Dismantle of services",
          style: TextStyle(
            color: Colors.white,
            fontSize: toolbarTitleSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => DismantleCreateCorrespondenceViewmodel(
          context: context,
        ),
        child: Consumer<DismantleCreateCorrespondenceViewmodel>(
            builder: (context, viewModel, child) {
              return Stack(children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: doubleEleven,
                        left: doubleEleven,
                        right: doubleEleven,
                        bottom: doubleTwentyFive),
                    child: Form(
                      key: viewModel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "USCNO",
                            style: TextStyle(color: Color(0xff5ba55e)),
                          ),
                          TextField(
                            controller: viewModel.uscNo,
                            maxLength: 8,
                            readOnly: viewModel.uscnoReadOnly,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                              counterText: "",
                              hintText: "USCNO",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 12),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                if (viewModel.uscnoReadOnly == isFalse &&
                                    viewModel.uscNo.text.length < 8) {
                                  AlertUtils.showSnackBar(
                                      context, "Please enter valid USCNO", isTrue);
                                } else {
                                  viewModel
                                      .getConsumerWithUscNo(viewModel.uscNo.text);
                                }
                              },
                              child: const Text(
                                "Fetch Details",
                                style: TextStyle(color: Colors.indigo),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 40,
                            alignment: Alignment.centerLeft,
                            color: Colors.blueGrey[50],
                            child: const Text(
                              "CONSUMER DETAILS",
                              style: TextStyle(color: CommonColors.deepBlue),
                            ),
                          ),
                          const SizedBox(
                            height: doubleTen,
                          ),
                          Table(
                            // border:TableBorder.all(width: 1.5,color:CommonColors.lightGrey),
                              border: const TableBorder.symmetric(
                                inside: BorderSide(
                                  width: 1.5,
                                  color: CommonColors.lightGrey,
                                ),
                              ),
                              columnWidths: const {
                                0: FlexColumnWidth(0.4), // 40% of the width
                                1: FlexColumnWidth(0.6), // 60% of the width
                              },
                              children: [
                                TableRow(
                                  children: [
                                    Visibility(
                                      visible:
                                      viewModel.fetchDetailsClicked == isTrue,
                                      child: const Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Text('USCNO'),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: doubleEight),
                                      child: TextField(
                                        controller: viewModel.consumerWithUscNo,
                                        readOnly: true,
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Visibility(
                                      visible:
                                      viewModel.fetchDetailsClicked == isTrue,
                                      child: const Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Text('SCNO/CAT'),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: doubleEight),
                                      child: TextField(
                                        controller: viewModel.scNoCat,
                                        readOnly: true,
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Visibility(
                                      visible:
                                      viewModel.fetchDetailsClicked == isTrue,
                                      child: const Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Text('CONSUMER NAME'),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: doubleEight),
                                      child: TextField(
                                        controller: viewModel.consumerName,
                                        readOnly: true,
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Visibility(
                                      visible:
                                      viewModel.fetchDetailsClicked == isTrue,
                                      child: const Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Text('ADDRESS LINE 1'),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: doubleEight),
                                      child: TextField(
                                        controller: viewModel.addressLine1,
                                        readOnly: true,
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Visibility(
                                      visible:
                                      viewModel.fetchDetailsClicked == isTrue,
                                      child: const Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Text('ADDRESS LINE 2'),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: doubleEight),
                                      child: TextField(
                                        controller: viewModel.addressLine2,
                                        readOnly: true,
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Visibility(
                                      visible:
                                      viewModel.fetchDetailsClicked == isTrue,
                                      child: const Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Text('ADDRESS LINE 3'),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: doubleEight),
                                      child: TextField(
                                        controller: viewModel.addressLine3,
                                        readOnly: true,
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Visibility(
                                      visible:
                                      viewModel.fetchDetailsClicked == isTrue,
                                      child: const Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text('ADDRESS LINE 4'),
                                              Divider(),
                                            ]),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: doubleEight),
                                      child: TextField(
                                        controller: viewModel.addressLine4,
                                        readOnly: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                          const SizedBox(
                            height: doubleTen,
                          ),
                          const Divider(),
                          Container(
                            width: double.infinity,
                            height: 40,
                            color: Colors.blueGrey[50],
                            // padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "METER AVAILABLE",
                                  style: TextStyle(color: CommonColors.deepBlue),
                                ),
                                Switch(
                                  value: viewModel.meterAvailableSwitch,
                                  onChanged: (value) {
                                    viewModel.meterAvailable = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: viewModel.meterAvailableSwitch == isTrue,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "MAKE",
                                    style: TextStyle(color: Color(0xff5ba55e)),
                                  ),
                                  DropdownButtonFormField<String>(
                                    value: viewModel.meterMakeName,
                                    hint: viewModel.meterMakesMap.isNotEmpty
                                        ? const Text("Select an option")
                                        : const Text(""),
                                    isExpanded: true,
                                    items: viewModel.meterMakesMap
                                        .map((item) => DropdownMenuItem<String>(
                                      value: item.optionId,
                                      child: Text(item.optionName),
                                    ))
                                        .toList(),
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(width: 1, color: Colors.grey),
                                        )),
                                    onChanged: (newValue) {
                                      viewModel.updateOldMeterMake(newValue!);
                                    },
                                  ),
                                  const SizedBox(
                                    height: doubleTen,
                                  ),
                                  const Text(
                                    "SERIAL NO",
                                    style: TextStyle(color: Color(0xff5ba55e)),
                                  ),
                                  TextField(
                                    controller: viewModel.serialNo,
                                    maxLength: 30,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      counterText: "",
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 12),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: doubleTen,
                                  ),
                                  Text(
                                    "capacity".toUpperCase(),
                                    style:
                                    const TextStyle(color: Color(0xff5ba55e)),
                                  ),
                                  TextField(
                                    controller: viewModel.capacity,
                                    maxLength: 15,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      counterText: "",
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 12),
                                    ),
                                  ),
                                  // FillTextFormField(controller: viewModel.capacity, labelText: "CAPACITY", keyboardType: TextInputType.text),
                                  const SizedBox(
                                    height: doubleTen,
                                  ),
                                  Row(children: [
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "KWH",
                                              style:
                                              TextStyle(color: Color(0xff5ba55e)),
                                            ),
                                            TextField(
                                              controller: viewModel.kwh,
                                              maxLength: 16,
                                              keyboardType: TextInputType.text,
                                              decoration: const InputDecoration(
                                                counterText: "",
                                                border: OutlineInputBorder(),
                                                contentPadding: EdgeInsets.symmetric(
                                                    horizontal: 10, vertical: 12),
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                    const SizedBox(
                                      width: doubleTen,
                                    ),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "KVAH",
                                              style:
                                              TextStyle(color: Color(0xff5ba55e)),
                                            ),
                                            TextField(
                                              controller: viewModel.kvah,
                                              maxLength: 20,
                                              keyboardType: TextInputType.text,
                                              decoration: const InputDecoration(
                                                counterText: "",
                                                border: OutlineInputBorder(),
                                                contentPadding: EdgeInsets.symmetric(
                                                    horizontal: 10, vertical: 12),
                                              ),
                                            ),
                                          ],
                                        ))
                                  ]),
                                  const Divider(),
                                  const Text(
                                    "Disconnection Date",
                                    style: TextStyle(color: Color(0xff5ba55e)),
                                  ),
                                  TextField(
                                    controller: viewModel.disConnectionDate,
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime.now(),
                                      );
                                      if (pickedDate != null) {
                                        final formattedDate = DateFormat('dd/MM/yyyy')
                                            .format(pickedDate); // e.g., "14/04/2025"
                                        viewModel.setFromDate(formattedDate);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      hintText: "TAP HERE",
                                      fillColor: Colors.grey[200],
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 12),
                                    ),
                                  ),
                                ]),
                          ),
                          const Divider(),
                          const SizedBox(
                            height: doubleTen,
                          ),
                          const Text(
                            "UPLOAD CONSUMER REPRESENTATION",
                            style: TextStyle(color: Color(0xff5ba55e)),
                          ),
                          TextField(
                            readOnly: true,
                            controller:
                            TextEditingController(text: viewModel.fileName),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.upload_file,
                                  size: doubleForty,
                                ),
                                onPressed: viewModel.pickDocument,
                              ),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: doubleTen,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: PrimaryButton(
                                text: "SUBMIT",
                                onPressed: () {
                                  viewModel.submitForm();
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (viewModel.isLoading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                      // Optional: dim background
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ]);
            }),
      ),
    );
  }
}
