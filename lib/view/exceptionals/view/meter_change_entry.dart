import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/exceptionals/viewmodel/meter_change_entry_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class MeterChangeEntryScreen extends StatelessWidget {
  static const id = Routes.meterChangeEntryScreen;
  final Map<String, dynamic> args;

  const MeterChangeEntryScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final TextEditingController uscnoController =
        TextEditingController(text: args['t'].toInt().toString());
    final TextEditingController scnoController =
        TextEditingController(text: args['sc'].toString());
    final TextEditingController consumerNameController =
        TextEditingController(text: args['n']);

    return ChangeNotifierProvider(
      create: (_) =>
          MeterChangeEntryScreenViewModel(context: context, args: args),
      child: Consumer<MeterChangeEntryScreenViewModel>(
          builder: (context, viewModel, child) {
        print('Read only value : ${viewModel.unableToScanOldMeterNo} ');
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'METER CHANGE ENTRY',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: toolbarTitleSize,
                  fontWeight: FontWeight.w700),
            ),
            backgroundColor: CommonColors.colorPrimary,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
          body: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : viewModel.barCodeScanOnOld || viewModel.barCodeScanOnNew
                  ? Container()
                  // ? MobileScanner(
                  //     onDetect: (result) {
                  //       viewModel.getBarCode(context, result);
                  //     },
                  //   )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 11,
                            ),
                            const Center(
                                child: Text(
                              'Replacing meter for USCNO',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                            const SizedBox(
                              height: 11,
                            ),
                            TextFormField(
                              controller: uscnoController,
                              decoration: const InputDecoration(
                                  label: Text('USCNO :'),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            TextFormField(
                              controller: scnoController,
                              decoration: const InputDecoration(
                                  label: Text('SCNO :'),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            TextFormField(
                              controller: consumerNameController,
                              decoration: const InputDecoration(
                                  label: Text('Consummer Name  :'),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            const Center(
                                child: Text(
                              'Old Meter Particulars',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                            const SizedBox(
                              height: 11,
                            ),
                            TextFormField(
                              controller: viewModel.poNoController,
                              decoration: const InputDecoration(
                                  label: Text('PO NO ON OLD METER :'),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            TextFormField(
                              controller: viewModel.poDateController,
                              decoration: const InputDecoration(
                                  label: Text('PO DATE :'),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                              onTap: () {
                                viewModel.chooseDate(context);
                              },
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: TextFormField(
                                        controller:
                                            viewModel.oldMeterNoController,
                                        readOnly:
                                            !viewModel.unableToScanOldMeterNo,
                                        decoration: const InputDecoration(
                                            label: Text('OLD METER NO :'),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey))),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          height: 55,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5))),
                                              onPressed: () {
                                                viewModel.scanBarCode(context);
                                              },
                                              child: const Text('SCAN')),
                                        ))
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            viewModel.oldMeterNoImageVisibility
                                ? Container(
                                    width: double.infinity,
                                    height: 300,
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    child: viewModel.captureOldImage != null
                                        ? Image.file(
                                            viewModel.captureOldImage!,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(),
                                  )
                                : TextButton(
                                    onPressed: () {
                                      viewModel.showAttention(context, "old");
                                    },
                                    child: const Center(
                                        child: Text(
                                      'Unable to Scan?',
                                      style: TextStyle(color: Colors.red),
                                    ))),
                            const SizedBox(
                              width: 11,
                            ),
                            const Text(
                              'OLD METER MAKE :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            DropdownButtonFormField<String>(
                              value: viewModel.oldMeterMakeName,
                              hint: const Text("SELECT"),
                              isExpanded: true,
                              items: viewModel.optionNames.map((String name) {
                                return DropdownMenuItem<String>(
                                  value: name,
                                  child: Text(name),
                                );
                              }).toList(),
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
                              height: 11,
                            ),
                            const Text(
                              'METER PHASE',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: viewModel.oldSinglePhase,
                                  onChanged: (value) {
                                    viewModel.setOldSinglePhase(value!);
                                  },
                                ),
                                const Text('Single Phase'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: viewModel.oldThreePhase,
                                  onChanged: (value) {
                                    viewModel.setOldThreePhase(value!);
                                  },
                                ),
                                const Text('3 Phase'),
                              ],
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            const Text(
                              'OLD METER CAPACITY :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: viewModel.oldMeterCapacityController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            const Text(
                              'OLD METER STATUS :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: viewModel.oldMeterStatusController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            const Text(
                              'OLD METER FINAL READING  :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: viewModel.noDisplay,
                                  onChanged: (value) {
                                    viewModel.setNoDisplay(value!);
                                  },
                                ),
                                const Text('No Display'),
                              ],
                            ),
                            Visibility(
                              visible: !viewModel.noDisplay,
                              child: TextFormField(
                                controller:
                                    viewModel.oldMeterFinalReadingController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey))),
                              ),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            const Text(
                              'OLD METER SEAL BIT NO :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: viewModel.oldMeterSealBitController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            const Center(
                                child: Text(
                              'NEW Meter Particulars',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                            const SizedBox(
                              height: 11,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: TextFormField(
                                        controller:
                                            viewModel.newMeterNoController,
                                        readOnly:
                                            !viewModel.unableToScanNewMeterNo,
                                        decoration: const InputDecoration(
                                            label: Text('NEW METER NO :'),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey))),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          height: 55,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            onPressed: () {
                                              viewModel.scanBarCodeNew(context);
                                            },
                                            child: const Text('SCAN'),
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            viewModel.newMeterNoImageVisibility
                                ? Container(
                                    width: double.infinity,
                                    height: 300,
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    child: viewModel.captureNewImage != null
                                        ? Image.file(
                                            viewModel.captureNewImage!,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(),
                                  )
                                : TextButton(
                                    onPressed: () {
                                      viewModel.showAttention(context, "new");
                                    },
                                    child: const Center(
                                        child: Text(
                                      'Unable to Scan?',
                                      style: TextStyle(color: Colors.red),
                                    )),
                                  ),
                            const SizedBox(
                              height: 11,
                            ),
                            const Text(
                              'NEW METER MAKE :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            DropdownButtonFormField<String>(
                              value: viewModel.newMeterMakeName,
                              hint: const Text("SELECT"),
                              isExpanded: true,
                              items: viewModel.optionNames.map((String name) {
                                return DropdownMenuItem<String>(
                                  value: name,
                                  child: Text(name),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                              )),
                              onChanged: (newValue) {
                                viewModel.updateNewMeterMake(newValue!);
                              },
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            const Text(
                              'NEW METER PHASE',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: viewModel.newSinglePhase,
                                  onChanged: (value) {
                                    viewModel.setNewSinglePhase(value!);
                                  },
                                ),
                                const Text('Single Phase'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: viewModel.newThreePhase,
                                  onChanged: (value) {
                                    viewModel.setNewThreePhase(value!);
                                  },
                                ),
                                const Text('3 Phase'),
                              ],
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            const Text(
                              'NEW METER INITIAL READING :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller:
                                  viewModel.newMeterInitialReadingController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            const Text(
                              'NEW METER BOX',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: viewModel.withBox,
                                  onChanged: (value) {
                                    viewModel.setWithBox(value!);
                                  },
                                ),
                                const Text('Fixed with box'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: viewModel.withoutBox,
                                  onChanged: (value) {
                                    viewModel.setWithoutBox(value!);
                                  },
                                ),
                                const Text('Fixed without box'),
                              ],
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            const Text(
                              'SEAL BIT NO :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: viewModel.newMeterSealBitNoController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            const Text(
                              'METER TYPE :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            DropdownButtonFormField<String>(
                              value: viewModel.meterType,
                              hint: const Text("SELECT"),
                              isExpanded: true,
                              items:
                                  viewModel.meterTypeOptions.map((String name) {
                                return DropdownMenuItem<String>(
                                  value: name,
                                  child: Text(name),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                              )),
                              onChanged: (newValue) {
                                viewModel.updateMeterType(newValue!);
                              },
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            PrimaryButton(
                              text: 'SUBMIT',
                              onPressed: () {
                                if (viewModel.validate(context)) {
                                  viewModel.saveMeterDetails(context);
                                }
                              },
                              fullWidth: isTrue,
                            ),
                            const SizedBox(
                              height: 21,
                            )
                          ],
                        ),
                      ),
                    ),
        );
      }),
    );
  }
}
