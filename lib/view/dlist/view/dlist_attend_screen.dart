import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/dlist/viewmodel/dlist_attend_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/dlist_attend_tile_widget.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class DlistAttendScreen extends StatelessWidget {
  static const id = Routes.dlistAttendScreen;
  final String data;

  const DlistAttendScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DlistAttendViewmodel(context: context, data: data),
      child: Consumer<DlistAttendViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${viewModel.dlistEntityRealmList!.dlscno}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: titleSize,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(
                    "₹${viewModel.dlistEntityRealmList!.dlamt}",
                    style: const TextStyle(fontSize: normalSize, color: Colors.grey),
                  ),
                ],
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      viewModel.driveIconClicked();
                    },
                    icon: const Icon(Icons.drive_eta_rounded, color: Colors.white,)
                )
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(doubleTen),
              child: Column(
                children: [
                  Card(
                    color: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.all(doubleTen),
                      child: Column(
                        children: [
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              "Already UDC",
                              style: TextStyle(fontSize: normalSize, fontWeight: FontWeight.w500),
                            ),
                            value: viewModel.isSelected("Already UDC"),
                            onChanged: (value) {
                              viewModel.selectCheckbox("Already UDC");
                            },
                          ),
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              "Under Correspondence",
                              style: TextStyle(fontSize: normalSize, fontWeight: FontWeight.w500),
                            ),
                            value: viewModel.isSelected("Under Correspondence"),
                            onChanged: (value) {
                              viewModel.selectCheckbox("Under Correspondence");
                            },
                          ),
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              "Court case",
                              style: TextStyle(fontSize: normalSize, fontWeight: FontWeight.w500),
                            ),
                            value: viewModel.isSelected("Court case"),
                            onChanged: (value) {
                              viewModel.selectCheckbox("Court case");
                            },
                          ),
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              "Now Disconnected",
                              style: TextStyle(fontSize: normalSize, fontWeight: FontWeight.w500, color: Colors.red),
                            ),
                            value: viewModel.isSelected("Now Disconnected"),
                            onChanged: (value) {
                              viewModel.selectCheckbox("Now Disconnected");
                            },
                          ),
                          Visibility(
                            visible: viewModel.isSelected("Now Disconnected"),
                            child: Column(
                              children: [
                                FillTextFormField(
                                    controller: viewModel.finalReadingKwh,
                                    labelText: "Final Reading(KWH)",
                                    keyboardType: TextInputType.number
                                ),
                                const SizedBox(height: 20,),
                                FillTextFormField(
                                    controller: viewModel.finalReadingKvah,
                                    labelText: "Final Reading(KVAH)",
                                    keyboardType: TextInputType.number
                                ),
                                const SizedBox(height: 20,),
                                TextField(
                                  controller: viewModel.disconnectionDate,
                                  readOnly: true,
                                  onTap: () => viewModel.disconnectionDateClicked(),
                                  decoration: const InputDecoration(
                                    labelText: 'Disc Date',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              "Proposed for BS",
                              style: TextStyle(fontSize: normalSize, fontWeight: FontWeight.w500, color: Colors.red),
                            ),
                            value: viewModel.isSelected("Proposed for BS"),
                            onChanged: (value) {
                              viewModel.selectCheckbox("Proposed for BS");
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  controlAffinity: ListTileControlAffinity.leading,
                                  contentPadding: EdgeInsets.zero,
                                  title: const Text(
                                    "Full Amount Paid",
                                    style: TextStyle(fontSize: normalSize, fontWeight: FontWeight.w500, color: Colors.green),
                                  ),
                                  value: viewModel.isSelected("Full Amount Paid"),
                                  onChanged: (value) {
                                    viewModel.selectCheckbox("Full Amount Paid");
                                  },
                                ),
                              ),
                              Expanded(
                                child: CheckboxListTile(
                                  controlAffinity: ListTileControlAffinity.leading,
                                  contentPadding: EdgeInsets.zero,
                                  title: const Text(
                                    "Part Amount Paid",
                                    style: TextStyle(fontSize: normalSize, fontWeight: FontWeight.w500, color: Colors.brown),
                                  ),
                                  value: viewModel.isSelected("Part Amount Paid"),
                                  onChanged: (value) {
                                    viewModel.selectCheckbox("Part Amount Paid");
                                  },
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: viewModel.isSelected("Part Amount Paid"),
                            child: Column(
                              children: [
                                TextField(
                                  controller: viewModel.nbsDate,
                                  readOnly: true,
                                  onTap: () => viewModel.nbsDateClicked(),
                                  decoration: const InputDecoration(
                                    labelText: 'Next balance payment date',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 20,),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: viewModel.isSelected("Full Amount Paid") || viewModel.isSelected("Part Amount Paid"),
                            child: Column(
                              children: [
                                FillTextFormField(
                                    controller: viewModel.fullAmount,
                                    labelText: "Amount(Rs)",
                                    keyboardType: TextInputType.number
                                ),
                                const SizedBox(height: 20,),
                                FillTextFormField(
                                    controller: viewModel.prNumber,
                                    labelText: "PR No",
                                    keyboardType: TextInputType.number
                                ),
                                const SizedBox(height: 20,),
                                TextField(
                                  controller: viewModel.prDate,
                                  readOnly: true,
                                  onTap: () => viewModel.prDateClicked(),
                                  decoration: const InputDecoration(
                                    labelText: 'PR Date',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),
                          FillTextFormField(
                              controller: viewModel.remarks,
                              labelText: "Remarks",
                              keyboardType: TextInputType.text
                          ),
                          const SizedBox(height: 20,),
                          PrimaryButton(
                              text: "Submit",
                              onPressed: () {
                                viewModel.submitButtonClicked();
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    "Service Details",
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(height: doubleTen,),
                        DlistAttendTileWidget(tileKey: "Area", tileValue:  checkNull(viewModel.dlistEntityRealmList!.areaname)),
                        DlistAttendTileWidget(tileKey: "Arrears(₹)", tileValue:  checkNull(viewModel.dlistEntityRealmList!.arrears.toString())),
                        DlistAttendTileWidget(tileKey: "Address", tileValue:  checkNull(viewModel.dlistEntityRealmList!.ctadd2)),
                        DlistAttendTileWidget(tileKey: "Area Code", tileValue:  checkNull(viewModel.dlistEntityRealmList!.ctareacd)),
                        DlistAttendTileWidget(tileKey: "Consumer Name", tileValue:  checkNull(viewModel.dlistEntityRealmList!.ctname)),
                        DlistAttendTileWidget(tileKey: "Phone", tileValue:  checkNull(viewModel.dlistEntityRealmList!.ctphone.toString())),
                        DlistAttendTileWidget(tileKey: "Pole No", tileValue:  checkNull(viewModel.dlistEntityRealmList!.ctpoleno)),
                        DlistAttendTileWidget(tileKey: "Social Group", tileValue:  checkNull(viewModel.dlistEntityRealmList!.ctsocialgroup)),
                        DlistAttendTileWidget(tileKey: "Current Month Demand(₹)", tileValue:  checkNull(viewModel.dlistEntityRealmList!.curdem.toString())),
                        DlistAttendTileWidget(tileKey: "Disc. Date", tileValue:  checkNull(viewModel.dlistEntityRealmList!.discdt)),
                        DlistAttendTileWidget(tileKey: "Amount(₹)", tileValue:  checkNull(viewModel.dlistEntityRealmList!.dlamt.toString())),
                        DlistAttendTileWidget(tileKey: "Cat", tileValue:  checkNull(viewModel.dlistEntityRealmList!.dlcat.toString())),
                        DlistAttendTileWidget(tileKey: "DList Type", tileValue:  checkNull(viewModel.dlistEntityRealmList!.type)),
                        DlistAttendTileWidget(tileKey: "Month Year", tileValue:  checkNull(viewModel.dlistEntityRealmList!.dlmonyr)),
                        DlistAttendTileWidget(tileKey: "SC No", tileValue:  checkNull(viewModel.dlistEntityRealmList!.dlscno)),
                        DlistAttendTileWidget(tileKey: "Status", tileValue:  checkNull(viewModel.dlistEntityRealmList!.dlstat)),
                        DlistAttendTileWidget(tileKey: "USCNO", tileValue:  checkNull(viewModel.dlistEntityRealmList!.dluan.toString())),
                        DlistAttendTileWidget(tileKey: "Attended By", tileValue:  "-"),
                        DlistAttendTileWidget(tileKey: "ERO Code", tileValue:  checkNull(viewModel.dlistEntityRealmList!.erocode.toString())),
                        DlistAttendTileWidget(tileKey: "Section", tileValue:  checkNull(viewModel.dlistEntityRealmList!.j2SSection)),
                        DlistAttendTileWidget(tileKey: "Last Paid Date", tileValue:  checkNull(viewModel.dlistEntityRealmList!.lastpddt)),
                        DlistAttendTileWidget(tileKey: "Section", tileValue:  checkNull(viewModel.dlistEntityRealmList!.secname)),
                        const SizedBox(height: doubleTen,),
                      ],
                    )
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
