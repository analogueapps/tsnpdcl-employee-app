import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/dtr_failure/viewmodel/dtr_failure_report_viewmodel.dart';


class ReportDTRFailure extends StatelessWidget {
  static const id = Routes.dtrFailureReportingScreen;
  const ReportDTRFailure({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReportDTRFailureViewModel(),
      child: Consumer<ReportDTRFailureViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Report DTR failure'),
              backgroundColor: CupertinoColors.systemGreen,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('SELECT SECTION'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: DropdownButtonFormField<String>(
                        value: viewModel.selectedLocation,
                        items: viewModel.locationList.map((location) {
                          return DropdownMenuItem(
                            value: location,
                            child: Text(location),
                          );
                        }).toList(),
                        onChanged: (value) {
                          viewModel.setSelectedLocation(value);
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        hint: const Text('NAKKALAGUTTA'),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'NAKKALAGUTTA|402911201',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'SELECT FAILED STRUCTURE CODE',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Select Failed Structure Code"),
                                content: SizedBox(
                                  height: 300,
                                  width: double.maxFinite,
                                  child: ListView(
                                    children: viewModel.failedStructureCodeList.map((code) {
                                      return ListTile(
                                        title: Text(code),
                                        onTap: () {
                                          viewModel.setSelectedStructureCode(code);
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: viewModel.selectedStructureCode ??
                                  'Select Failed Structure Code',
                              border: const UnderlineInputBorder(),
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '12235-NAKKALAGUTTA-NKG-SS-0072',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'SELECT FAILED EQUIPMENT CODE',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: DropdownButtonFormField<String>(
                        value: viewModel.failedEquipmentCode,
                        items: viewModel.failedEquipmentList.map((code) {
                          return DropdownMenuItem(
                            value: code,
                            child: Text(code),
                          );
                        }).toList(),
                        onChanged: (value) {
                          viewModel.setFailedEquipmentCode(value);
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        hint: const Text('200049446'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        color: Colors.grey.shade400,
                        child: const Center(child: Text('STRUCTURE DETAILS')),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildStructureDetailRow('STRUCTURE CODE', '12241-NAKKALAGUTTA-NKG-SS-0078'),
                    _buildStructureDetailRow('LAND MARK', 'Corporate office 2'),
                    _buildStructureDetailRow('DISTRIBUTION', '12241-NAKKALAGUTTA-NKG-SS-0078'),
                    _buildStructureDetailRow('SS NO', 'SS-0078'),
                    _buildStructureDetailRow('SUB STATION', '12241-NAKKALAGUTTA'),
                    _buildStructureDetailRow('FEEDER', 'NAKKALAGUTTA-NKG-SS-0078'),
                    _buildStructureDetailRow('STRUCTURE CAPACITY', '1*135'),
                    _buildStructureDetailRow('STRUCTURE TYPE', 'Double pole'),
                    _buildStructureDetailRow('PLINTH TYPE', 'Pillar Type'),
                    _buildStructureDetailRow('AB SWITCH TYPE', 'Horizontal'),
                    _buildStructureDetailRow('HG FUSE SETS', 'Horizontal'),
                    _buildStructureDetailRow('LT FUSE SETS', 'Not Available'),
                    _buildStructureDetailRow('LT FUSE TYPE', 'Not Available'),
                    _buildStructureDetailRow('LOAD PATTERN', 'HT Service'),
                    _buildStructureDetailRow('STRUCTURE CODE', '18.005345'),
                    _buildStructureDetailRow('LONGITUDE', '79.78788'),
                    _buildStructureDetailRow('DATE OF CREATION', '2024-02-20 09:05:01.0'),
                    _buildStructureDetailRow('EMPLOYEE ID', '40005450'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          const Expanded(
                            child: SizedBox(
                              height: 100,
                              width: 50,
                              child: Icon(Icons.image),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('EQ CODE:200049446', style: TextStyle(color: Colors.red)),
                              Text('CAP:315kVA'),
                              Text('MAKE:VIJAYA ELECTRONICS'),
                              Text('SERIAL:1794764'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(thickness: 1, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'DTR FAILURE REASON',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Failure Date', style: TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: viewModel.dateController,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );
                                    if (pickedDate != null) {
                                      viewModel.setFailureDate("${pickedDate.toLocal()}".split(' ')[0]);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade400,
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Failure Time', style: TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: viewModel.timeController,
                                  onTap: () async {
                                    TimeOfDay? pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (pickedTime != null) {
                                      final formattedTime = pickedTime.format(context);
                                      viewModel.setFailureTime(formattedTime);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade400,
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(),
                    ),
                    _buildCheckboxRow(viewModel, 'highRatingHG', 'High Rating HG Fuses Used'),
                    _buildCheckboxRow(viewModel, 'highRatingLT', 'High Rating LT Fuses Used'),
                    _buildCheckboxRow(viewModel, 'ventPipeBurst', 'Vent Pipe Burst'),
                    _buildCheckboxRow(viewModel, 'gasketDamaged', 'Gasket damaged at tank cover'),
                    _buildCheckboxRow(viewModel, 'earthWireCut', 'Earth wire cut'),
                    _buildCheckboxRow(viewModel, 'looseLinesInTheEarth', 'Loose lines in the LT Line'),
                    _buildCheckboxRow(viewModel, 'phaseTouching', 'Phase Touching to Ground/Tree'),
                    _buildCheckboxRow(viewModel, 'phTouching', 'Ph Touching to body internally'),
                    _buildCheckboxRow(viewModel, 'dueToLightning', 'Due to lightning'),
                    _buildCheckboxRow(viewModel, 'heavyWind', 'Heavy Wind and Gale'),
                    _buildCheckboxRow(viewModel, 'dtrInstalled', 'DTR installed long back'),
                    _buildCheckboxRow(viewModel, 'improperHG', 'Improper HG Fuse wire'),
                    _buildCheckboxRow(viewModel, 'improperLT', 'Improper LT Fuse wire'),
                    _buildCheckboxRow(viewModel, 'tankCrack', 'Tank Crack OR Oil Leakage'),
                    _buildCheckboxRow(viewModel, 'moistureEntry', 'Moisture Entry'),
                    _buildCheckboxRow(viewModel, 'flashover', 'Flashover of Bushing'),
                    _buildCheckboxRow(viewModel, 'improperEarthing', 'Improper Earthing'),
                    _buildCheckboxRow(viewModel, 'overload', 'Overload'),
                    _buildCheckboxRow(viewModel, 'hgFuse', 'HG Fuse Not Standing'),
                    _buildCheckboxRow(viewModel, 'faultDueToAGL', 'Fault due to AGL Motor'),
                    _buildCheckboxRow(viewModel, 'oilGushing', 'Oil Gushing Out'),
                    _buildCheckboxRow(viewModel, 'lowOilLevel', 'Low Oil Level'),
                    _buildCheckboxRow(viewModel, 'tankBurst', 'Tank Burst'),
                    _buildCheckboxRow(viewModel, 'agingOfDTR', 'Aging of DTR'),
                    _buildCheckboxRow(viewModel, 'theftOfOil', 'Theft of Oil'),
                    _buildCheckboxRow(viewModel, 'floodsFallenOil', 'Floods-DTR Fallen-Oil shrt,Bushings dmgd'),
                    _buildCheckboxRow(viewModel, 'floodsSubmerged', 'Floods-DTR submerged in water'),
                    _buildCheckboxRow(viewModel, 'other', 'Other'),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(thickness: 1, color: Colors.grey),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'ESTIMATE REQUIRED?',
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: viewModel.estimateRequiredYes,
                                onChanged: (value) {
                                  viewModel.toggleCheckbox('estimateRequiredYes', value!);
                                },
                              ),
                              const SizedBox(width: 5),
                              const Text('Yes'),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: viewModel.estimateRequiredNo,
                                onChanged: (value) {
                                  viewModel.toggleCheckbox('estimateRequiredNo', value!);
                                },
                              ),
                              const SizedBox(width: 5),
                              const Text('No'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(thickness: 1, color: Colors.grey),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: viewModel.save,
                          child: const Text('SAVE'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStructureDetailRow(String label, String value) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text(value, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(thickness: 1, color: Colors.grey),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCheckboxRow(ReportDTRFailureViewModel viewModel, String field, String label) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Checkbox(
                value: _getCheckboxValue(viewModel, field),
                onChanged: (value) {
                  viewModel.toggleCheckbox(field, value!);
                },
              ),
              const SizedBox(width: 10),
              Text(label),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(thickness: 1, color: Colors.grey),
        ),
      ],
    );
  }

  bool _getCheckboxValue(ReportDTRFailureViewModel viewModel, String field) {
    switch (field) {
      case 'highRatingHG':
        return viewModel.highRatingHG;
      case 'highRatingLT':
        return viewModel.highRatingLT;
      case 'ventPipeBurst':
        return viewModel.ventPipeBurst;
      case 'gasketDamaged':
        return viewModel.gasketDamaged;
      case 'earthWireCut':
        return viewModel.earthWireCut;
      case 'looseLinesInTheEarth':
        return viewModel.looseLinesInTheEarth;
      case 'phaseTouching':
        return viewModel.phaseTouching;
      case 'phTouching':
        return viewModel.phTouching;
      case 'dueToLightning':
        return viewModel.dueToLightning;
      case 'heavyWind':
        return viewModel.heavyWind;
      case 'dtrInstalled':
        return viewModel.dtrInstalled;
      case 'improperHG':
        return viewModel.improperHG;
      case 'improperLT':
        return viewModel.improperLT;
      case 'tankCrack':
        return viewModel.tankCrack;
      case 'moistureEntry':
        return viewModel.moistureEntry;
      case 'flashover':
        return viewModel.flashover;
      case 'improperEarthing':
        return viewModel.improperEarthing;
      case 'overload':
        return viewModel.overload;
      case 'hgFuse':
        return viewModel.hgFuse;
      case 'faultDueToAGL':
        return viewModel.faultDueToAGL;
      case 'oilGushing':
        return viewModel.oilGushing;
      case 'lowOilLevel':
        return viewModel.lowOilLevel;
      case 'tankBurst':
        return viewModel.tankBurst;
      case 'agingOfDTR':
        return viewModel.agingOfDTR;
      case 'theftOfOil':
        return viewModel.theftOfOil;
      case 'floodsFallenOil':
        return viewModel.floodsFallenOil;
      case 'floodsSubmerged':
        return viewModel.floodsSubmerged;
      case 'other':
        return viewModel.other;
      default:
        return false;
    }
  }
}