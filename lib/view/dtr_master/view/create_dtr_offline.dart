import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';
import 'package:tsnpdcl_employee/view/dtr_master/view/spm_create_offline.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/createOffline_dtr_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

//CreateDtrStructureOfflineActivity

class CreateDtrOffline extends StatelessWidget {
  static const id = Routes.createOfflineDTR;
  const CreateDtrOffline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          GlobalConstants.createOfflineDTR.toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        },
            icon: const Icon(Icons.close)
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => OfflineDtrViewmodel(context: context),
        child: Consumer<OfflineDtrViewmodel>(
            builder: (context, viewModel, child) {
              return Stack(
                  children: [
                    SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Location of DTR", style: TextStyle(color: Colors
                              .purple[300]),),
                          Wrap(
                              spacing: 10.0,
                              runSpacing: 5.0,
                              alignment: WrapAlignment.start,
                              children: [
                                Row(children: [checkbox(context, "SPM"),
                                  checkbox(context, "STORE"),
                                  checkbox(context, "STRUCTURE"),
                                ]),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value: viewModel.subStationSelectedOffline=="SUB STATION",
                                    // Check if it's the selected option
                                    onChanged: (bool? newValue) {
                                      if (newValue == true) {
                                        viewModel.setSelectedSubStationOffline("SUB STATION");
                                      } else {
                                        viewModel.setSelectedSubStationOffline(""); // or "", depending on how you handle it
                                      }
                                    },
                                  ),
                                  Text("SUB STATION"),
                                ],
                              ),
                                Visibility(
                                  visible: viewModel.selectedFilter == null|| viewModel.selectedFilter=="STRUCTURE",
                                  child:
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                                    child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 50,
                                            color:Colors.grey[200],
                                            child: Center(child:Text(
                                              "DTR Structure Details",
                                              style: TextStyle(color: Colors.purple[300]
                                              ),
                                            ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text("Select Distribution", style: TextStyle(fontSize: 15,color:Colors.purple[300]),),
                                          DropdownButton<String>(
                                            isExpanded: true,
                                            hint: const Text("Select"),
                                            value: viewModel.selectedDistributionOffline,
                                            items: viewModel.distributionsOffline.map((SubstationModel item) {
                                              return DropdownMenuItem<String>(
                                                value: item.optionCode,
                                                child: Text(item.optionName),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) {
                                              if (value != null) {
                                                final selectedItem = viewModel.distributionsOffline.firstWhere(
                                                      (item) => item.optionCode == value,
                                                );
                                                viewModel.onListDistriSelectedOffline(value, selectedItem.optionName);
                                              }
                                            },
                                          ),
                                          const SizedBox(height: 5),
                                          Text("SS No.", style: TextStyle(fontSize: 15,color:Colors.purple[300])),
                                          DropdownButton<String>(
                                            isExpanded: true,
                                            hint: const Text("Select"),
                                            value: viewModel.selectedSSNoOffline,
                                            items: viewModel.ssnoOffline.map<DropdownMenuItem<String>>((item) {
                                              return DropdownMenuItem<String>(
                                                value: item, // Assuming ssno is a List<String>
                                                child: Text(item),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) => viewModel.onListSSNoSelectedOffline(value),
                                          ),
                                          const SizedBox(height: 5),

                                          Text("Please select feeding details to DTR structure", textAlign: TextAlign.center, style: TextStyle(color:Colors.grey[700]),),

                                          const SizedBox(height: 5),
                                          Text("Select Circle", style: TextStyle(fontSize: 15, color:Colors.purple[300])),
                                          DropdownButton<String>(
                                            isExpanded: true,
                                            hint: const Text("Select"),
                                            value: viewModel.selectedCircleOffline,
                                            items: viewModel.circleOffline.map<DropdownMenuItem<String>>((Circle item) {
                                              return DropdownMenuItem<String>(
                                                value: item.circleId,
                                                child: Text(item.circleName),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) => viewModel.onListCircleSelectedOffline(value),
                                          ),
                                          const SizedBox(height: 5),
                                          Text("Sub Station", style: TextStyle(fontSize: 15, color:Colors.purple[300])),
                                          DropdownButton<String>(
                                            isExpanded: true,
                                            hint: const Text("Select"),
                                            value: viewModel.selectedStation,
                                            items: viewModel.stationOffline.map<DropdownMenuItem<String>>((SubstationModel item) {
                                              return DropdownMenuItem<String>(
                                                value: item.optionCode,
                                                child: Text(item.optionName),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) => viewModel.onListStationSelectedOffline(value),
                                          ),
                                          const SizedBox(height: 5),
                                          Text("Choose Feeder", style: TextStyle(fontSize: 15, color:Colors.purple[300])),
                                          DropdownButton<String>(
                                            isExpanded: true,
                                            hint: const Text("Select"),
                                            value: viewModel.selectedFeederOffline,
                                            items: viewModel.feederOffline.map<DropdownMenuItem<String>>((SubstationModel item) {
                                              return DropdownMenuItem<String>(
                                                value: item.optionCode,
                                                child: Text(item.optionName),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) => viewModel.onListFeederSelectedOffline(value),
                                          ),
                                          const SizedBox(height: 5),
                                          Text("Structure Capacity", style: TextStyle(fontSize: 15, color:Colors.purple[300])),
                                          DropdownButton<int>(
                                            isExpanded: true,
                                            hint: const Text("Select"),
                                            value: viewModel.selectedCapacityIndex,
                                            items: viewModel.capacityOffline.asMap().entries.map<DropdownMenuItem<int>>((entry) {
                                              final index = entry.key;
                                              final item = entry.value;
                                              return DropdownMenuItem<int>(
                                                value: index,
                                                child: Text(item.optionName),
                                              );
                                            }).toList(),
                                            onChanged: viewModel.onListCapacitySelectedOffline,
                                          ),

                                          const SizedBox(height: 20,),
                                          Text("SAP DTR Structure Code(*)", style: TextStyle(fontSize:15,color:Colors.purple[300]),),
                                          FillTextFormField(
                                            controller: viewModel.sapDTRStructCodeOffline,
                                            labelText: '',
                                            isEnable: false,
                                            keyboardType: TextInputType.number,
                                          ),
                                          const SizedBox(height: 20,),
                                          Text("DTR Structure Location LandMark", style: TextStyle(fontSize:15, color:Colors.purple[300] ),),
                                          FillTextFormField(
                                            controller: viewModel.dtrLocatLandMarkOffline,
                                            labelText: '',
                                            keyboardType: TextInputType.text,
                                          ),
                                          dropDown(context, "DTR Structure Type(*)","Select", viewModel.selectedDTRTypeOffline,viewModel.dTRtypeOffline,viewModel.onListDTRTypeSelectedOffline ),
                                          dropDown(context, "Plinth Type(*)","Select", viewModel.selectedPlintTypeOffline,viewModel.plintTypeOffline,viewModel.onListPlintTypeSelectedOffline ),
                                          dropDown(context, "AB Switch","Select", viewModel.selectedABSwitchOffline,viewModel.aBSwitchOffline,viewModel.onListABSwitchSelectedOffline ),
                                          dropDown(context, "HG Fuse Sets(*)","Select", viewModel.selectedHGFuseOffline,viewModel.hGFuseOffline,viewModel.onListHGFuseSelectedOffline ),
                                          dropDown(context, "LT Fuse Sets(*)","Select", viewModel.selectedLTFuseSetOffline,viewModel.lTFuseSetOffline,viewModel.onListLTFuseSelectedOffline ),
                                          dropDown(context, "LT Fuse Type(*)","Select", viewModel.selectedLTFuseTypeOffline,viewModel.lTTypeOffline,viewModel.onListLTFuseTypeSelectedOffline ),
                                          dropDown(context, "Load Pattern","Select", viewModel.selectedLoadPatternOffline,viewModel.loadPatternOffline,viewModel.onListLoadPatternSelectedOffline ),
                                          Container(
                                            height: 50,
                                            color:Colors.grey[200],
                                            child: Center(child:Text(
                                              "DTR  Details",
                                              style: TextStyle(color: Colors.purple[300]
                                              ),
                                            ),
                                            ),
                                          ),
                                          // Capacity is selected  displayed Card
                                          Visibility(
                                            visible: viewModel.selectedCapacityOffline != null &&
                                                viewModel.selectedCapacityOffline!.isNotEmpty &&
                                                viewModel.selectedCapacityOffline != "Select",
                                            child:           Card(
                                              elevation: 3,
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: SizedBox(
                                                  width: double.infinity, // Ensure finite width
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min, // Use minimal vertical space
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded( // Ensure the dropdown has finite width
                                                            child: dtrDrops(
                                                              "Make",
                                                              viewModel.selectedMakeOffline,
                                                              viewModel.make,
                                                              viewModel.onListMakeOffline,
                                                            ),
                                                          ),
                                                          const IconButton(
                                                            onPressed: null,
                                                            icon: Icon(Icons.search, color: CommonColors.pink),
                                                          ),
                                                        ],
                                                      ),
                                                      dtrDrops(
                                                        "Capacity",
                                                        viewModel.selectedDtrCapacityOffline,
                                                        viewModel.dtrCapacity,
                                                        viewModel.onListDtrCapacityOffline,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 150, // Fixed width for all labels
                                                            child: Text("First time DTR\n "
                                                                "Charged/Energised\n Date",
                                                              style: TextStyle(color: Colors.purple[300]),),
                                                          ),
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () async {
                                                                final DateTime? pickedDate = await showDatePicker(
                                                                  context: context,
                                                                  initialDate: DateTime.now(),
                                                                  firstDate: DateTime(2000),
                                                                  lastDate: DateTime.now(),
                                                                );
                                                                if (pickedDate != null) {
                                                                  // Format the date as DD/MM/YYYY
                                                                  final formattedDate = "${pickedDate.day
                                                                      .toString().padLeft(2, '0')}/${pickedDate
                                                                      .month.toString().padLeft(
                                                                      2, '0')}/${pickedDate.year}";
                                                                  viewModel.first_time_charged_dateOffline.text =
                                                                      formattedDate;
                                                                }
                                                              },
                                                              child: IgnorePointer(
                                                                child: TextFormField(
                                                                  controller: viewModel
                                                                      .first_time_charged_dateOffline,
                                                                  decoration: const InputDecoration(
                                                                    labelText: 'DD/MM/YYYY',
                                                                    border: OutlineInputBorder(),
                                                                    // suffixIcon: Icon(Icons.calendar_today),
                                                                  ),

                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Divider(),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 150, // Fixed width for all labels
                                                            child: Text("Serial No ",
                                                              style: TextStyle(color: Colors.purple[300]),),
                                                          ),
                                                          Expanded(child:
                                                          FillTextFormField(
                                                            controller: viewModel.serialNoOffline,
                                                            labelText: '',
                                                            keyboardType: TextInputType.text,
                                                          )
                                                          ),
                                                        ],
                                                      ),

                                                      const Text(
                                                        "If Serial No. is not available Please click here",
                                                        style: TextStyle(color: Colors.red, fontSize: 12),),
                                                      const Align(
                                                        alignment: Alignment.bottomRight,
                                                        child:
                                                        Text("Request Serial No",
                                                          style: TextStyle(color: Colors.blueAccent),
                                                          textAlign: TextAlign.right,),
                                                      ),
                                                      const SizedBox(height: 20,),
                                                      const Text(
                                                        "👉🏻 Please Paint the Serial No on the DTR and capture the photo of DTR",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      const Divider(),
                                                      dtrDrops(
                                                        "Year of Mfg",
                                                        viewModel.selectedYearOfMfgOffline,
                                                        viewModel.yearOfMfg,
                                                        viewModel.onListYearOfMfgOffline,
                                                      ),

                                                      dtrDrops(
                                                        "Phase",
                                                        viewModel.selectedPhaseOffline,
                                                        viewModel.phase,
                                                        viewModel.onListPhaseOffline,
                                                      ),

                                                      dtrDrops(
                                                        "Ratio",
                                                        viewModel.selectedRatioOffline,
                                                        viewModel.ratio,
                                                        viewModel.onListRatioOffline,
                                                      ),
                                                      const Divider(),
                                                      dtrDrops(
                                                        "Select Type of \n"
                                                            "meter (LV side)",
                                                        viewModel.selectedTypeOfMeterOffline,
                                                        viewModel.typeOfMeter,
                                                        viewModel.onListTypeOfMeterOffline,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 150, // Fixed width for all labels
                                                            child: Text("SAP DTR Equp.\n"
                                                                "No(Painted On DTR)",
                                                                style: TextStyle(color: Colors.purple[300])),
                                                          ),
                                                          Expanded(child:
                                                          FillTextFormField(
                                                            controller: viewModel.sap_dtrOffline,
                                                            labelText: '',
                                                            keyboardType: TextInputType.text,
                                                          )
                                                          ),
                                                        ],
                                                      ),
                                                      const Text(
                                                        "👉🏻 Please Paint the Equipment code  on the DTR and capture the photo of DTR",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      const SizedBox(height: 10,),
                                                      _buildPlaceholder(),
                                                      const SizedBox(height: 10,),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                              //backgroundColor: CommonColors.colorPrimary,
                                                              backgroundColor: Colors.deepOrangeAccent,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(5),
                                                              ),
                                                              //elevation: 15.0,
                                                            ),
                                                            child: const Text("CAPTURE DTR PHOTO",
                                                              style: TextStyle(color: Colors.white),),
                                                            onPressed: () {

                                                            }
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                            ,
                                          ),
                                        ]
                                    ),
                                  ),
                                ),
                                Visibility(
                                    visible:viewModel.selectedFilter =="SPM",
                                    child: const SpmCreateOffline(),
                                ),
                                Visibility(
                                    visible:viewModel.selectedFilter =="STORE",
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Text("Select Physical Location Of DTR", style: TextStyle(fontSize:15, color:Colors.purple[300]),),
                                    DropdownButton<String>(
                                      isExpanded: true,
                                      hint:  Text("SELECT", style: const TextStyle(color: Colors.black),),
                                      value: viewModel.selectedPhysicalLocation,
                                      items: viewModel.listPhysicalLocation.map((item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item),
                                        );
                                      }).toList(),
                                      onChanged: (value) => viewModel.onListPhysicalLocation(value),
                                    ),
                                    const SizedBox(height: 10,),
                                        Container(
                                          height: 50,
                                          color: Colors.grey[200],
                                          child: Center(child: Text(
                                            "DTR  Details",
                                            style: TextStyle(color: Colors.purple[300]
                                            ),
                                          ),
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Card(
                                  elevation: 3,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SizedBox(
                                      width: double.infinity, // Ensure finite width
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min, // Use minimal vertical space
                                        children: [
                                          Row(
                                            children: [
                                              Expanded( // Ensure the dropdown has finite width
                                                child: dtrDrops(
                                                  "Make",
                                                  viewModel.selectedMakeOffline,
                                                  viewModel.make,
                                                  viewModel.onListMakeOffline,
                                                ),
                                              ),
                                              const IconButton(
                                                onPressed: null,
                                                icon: Icon(Icons.search, color: CommonColors.pink),
                                              ),
                                            ],
                                          ),
                                          dtrDrops(
                                            "Capacity",
                                            viewModel.selectedDtrCapacityOffline,
                                            viewModel.dtrCapacity,
                                            viewModel.onListDtrCapacityOffline,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 150, // Fixed width for all labels
                                                child: Text("First time DTR\n "
                                                    "Charged/Energised\n date",
                                                  style: TextStyle(color: Colors.purple[300]),),
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () async {
                                                    final DateTime? pickedDate = await showDatePicker(
                                                      context: context,
                                                      initialDate: DateTime.now(),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime.now(),
                                                    );
                                                    if (pickedDate != null) {
                                                      // Format the date as DD/MM/YYYY
                                                      final formattedDate = "${pickedDate.day
                                                          .toString().padLeft(2, '0')}/${pickedDate
                                                          .month.toString().padLeft(
                                                          2, '0')}/${pickedDate.year}";
                                                      viewModel.first_time_charged_dateOffline.text =
                                                          formattedDate;
                                                    }
                                                  },
                                                  child: IgnorePointer(
                                                    child: TextFormField(
                                                      controller: viewModel
                                                          .first_time_charged_dateOffline,
                                                      decoration: const InputDecoration(
                                                        labelText: 'DD/MM/YYYY',
                                                        border: OutlineInputBorder(),
                                                        // suffixIcon: Icon(Icons.calendar_today),
                                                      ),

                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 150, // Fixed width for all labels
                                                child: Text("Serial No ",
                                                  style: TextStyle(color: Colors.purple[300]),),
                                              ),
                                              Expanded(child:
                                              FillTextFormField(
                                                controller: viewModel.serialNoOffline,
                                                labelText: '',
                                                keyboardType: TextInputType.text,
                                              )
                                              ),
                                            ],
                                          ),

                                          const Text(
                                            "If Serial No. is not available Please click here",
                                            style: TextStyle(color: Colors.red, fontSize: 12),),
                                          const Align(
                                            alignment: Alignment.bottomRight,
                                            child:
                                            Text("Request Serial No",
                                              style: TextStyle(color: Colors.blueAccent),
                                              textAlign: TextAlign.right,),
                                          ),
                                          const SizedBox(height: 20,),
                                          const Text(
                                            "👉🏻 Please Paint the Serial No on the DTR and capture the photo of DTR",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          const Divider(),
                                          dtrDrops(
                                            "Year of Mfg",
                                            viewModel.selectedYearOfMfgOffline,
                                            viewModel.yearOfMfg,
                                            viewModel.onListYearOfMfgOffline,
                                          ),

                                          dtrDrops(
                                            "Phase",
                                            viewModel.selectedPhaseOffline,
                                            viewModel.phase,
                                            viewModel.onListPhaseOffline,
                                          ),

                                          dtrDrops(
                                            "Ratio",
                                            viewModel.selectedRatioOffline,
                                            viewModel.ratio,
                                            viewModel.onListRatioOffline,
                                          ),
                                          const Divider(),
                                          dtrDrops(
                                            "Select Type of \n"
                                                "meter (LV side)",
                                            viewModel.selectedTypeOfMeterOffline,
                                            viewModel.typeOfMeter,
                                            viewModel.onListTypeOfMeterOffline,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 150, // Fixed width for all labels
                                                child: Text("SAP DTR Equp.\n"
                                                    "No(Painted On DTR)",
                                                    style: TextStyle(color: Colors.purple[300])),
                                              ),
                                              Expanded(child:
                                              FillTextFormField(
                                                controller: viewModel.sap_dtrOffline,
                                                labelText: '',
                                                keyboardType: TextInputType.text,
                                              )
                                              ),
                                            ],
                                          ),
                                          const Text(
                                            "👉🏻 Please Paint the Equipment code on the DTR and capture the photo of DTR",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          const SizedBox(height: 10,),
                                          _buildPlaceholder(),
                                          const SizedBox(height: 10,),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  //backgroundColor: CommonColors.colorPrimary,
                                                  backgroundColor: Colors.deepOrangeAccent,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  //elevation: 15.0,
                                                ),
                                                child: const Text("CAPTURE DTR PHOTO",
                                                  style: TextStyle(color: Colors.white),),
                                                onPressed: () {

                                                }
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                    ]

                                ),
                                ),
                              ]
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: PrimaryButton(
                                text: "SUBMIT",
                                onPressed: () {
                                  // viewModel.submitForm();
                                }
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
              ),
              ]
              );
            }
        ),
      ),
    );
  }

  Widget checkbox(BuildContext context, String title) {
    return Consumer<OfflineDtrViewmodel>(
      builder: (context, viewModel, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: viewModel.selectedFilter == title,
              // Check if it's the selected option
              onChanged: (bool? newValue) {
                if (newValue == true) {
                  viewModel.setSelectedFilter(title); // Update ViewModel
                }
              },
            ),
            Text(title),
          ],
        );
      },
    );
  }

  Widget dropDown(BuildContext context, String title, String hintText, String? vmValue, List vmIteam, Function onListSelected){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20,),
        Text(title, style: TextStyle(fontSize:15, color:Colors.purple[300]),),
        DropdownButton<String>(
          isExpanded: true,
          hint:  Text(hintText, style: const TextStyle(color: Colors.black),),
          value: vmValue,
          items: vmIteam.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (value) => onListSelected(value),
        ),
      ],
    );
  }

  Widget dtrDrops(String title, String? dtrValue, List dtrItems, Function changedDetails) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 150, // Fixed width for all labels
            child: Text(
              title,
              style: TextStyle(color: Colors.purple[300]),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Select", style: TextStyle(color: Colors.black)),
              value: dtrValue,
              items: dtrItems.map<DropdownMenuItem<String>>((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                );
              }).toList(),
              onChanged: (value) => changedDetails(value),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Icon(
          Icons.photo_library,
          size: 50,
          color: Colors.grey,
        ),
      ),
    );
  }


}

