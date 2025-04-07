import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/createOnline_dtr_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class CreateDtrOnline extends StatelessWidget {
  static const id= Routes.createOnlineDTR;
  const CreateDtrOnline({super.key});

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (_) => OnlineDtrViewmodel(context:context),
      child: Consumer<OnlineDtrViewmodel>(
          builder: (context, viewModel, child) {
            return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          GlobalConstants.createOnlineDTR.toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
            icon: const Icon(Icons.close)
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          TextButton(
              onPressed: (){
                viewModel.getMake();
                if(viewModel.make.isNotEmpty){
                  showSuccessDialog(context, "Make Updated successfully",
                        () {
            Navigation.instance.pushBack();
          },
                  );
          }
          },
              child: const Text("UPDATE DTR MAKES", style: TextStyle(color: Colors.white),))
        ],
      ),
      body: Stack(
                  children: [
                    SingleChildScrollView(
                child:Padding(
                  padding: const EdgeInsets.all(5),
                  child:Form(
                    key: viewModel.formKey,
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Location of DTR", style: TextStyle(color: Colors.purple[300]),),
                          Wrap(
                            spacing: 10.0,
                            runSpacing: 5.0,
                            alignment: WrapAlignment.start,
                            children: [
                              checkbox(context, "STRUCTURE"),
                              checkbox(context, "SUB STATION"),
                              Visibility(
                                visible: viewModel.selectedFilter == null || viewModel.selectedFilter == "STRUCTURE",
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
                                          value: viewModel.selectedDistribution,
                                          items: viewModel.distributions.map((SubstationModel item) {
                                            return DropdownMenuItem<String>(
                                              value: item.optionCode,
                                              child: Text(item.optionName),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) {
                                            if (value != null) {
                                              final selectedItem = viewModel.distributions.firstWhere(
                                                    (item) => item.optionCode == value,
                                              );
                                              viewModel.onListDistriSelected(value, selectedItem.optionName);
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 5),
                                         Text("SS No.", style: TextStyle(fontSize: 15,color:Colors.purple[300])),
                                        DropdownButton<String>(
                                          isExpanded: true,
                                          hint: const Text("Select"),
                                          value: viewModel.selectedSSNo,
                                          items: viewModel.ssno.map<DropdownMenuItem<String>>((item) {
                                            return DropdownMenuItem<String>(
                                              value: item, // Assuming ssno is a List<String>
                                              child: Text(item),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) => viewModel.onListSSNoSelected(value),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "Please select feeding details to DTR structure",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.grey[700]),
                                        ),
                                        const SizedBox(height: 5),
                                         Text("Select Circle", style: TextStyle(fontSize: 15, color:Colors.purple[300])),
                                        DropdownButton<String>(
                                          isExpanded: true,
                                          hint: const Text("Select"),
                                          value: viewModel.selectedCircle,
                                          items: viewModel.circle.map<DropdownMenuItem<String>>((Circle item) {
                                            return DropdownMenuItem<String>(
                                              value: item.circleId,
                                              child: Text(item.circleName),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) => viewModel.onListCircleSelected(value),
                                        ),
                                        const SizedBox(height: 5),
                                         Text("Sub Station", style: TextStyle(fontSize: 15, color:Colors.purple[300])),
                                        DropdownButton<String>(
                                          isExpanded: true,
                                          hint: const Text("Select"),
                                          value: viewModel.selectedStation,
                                          items: viewModel.stations.map<DropdownMenuItem<String>>((SubstationModel item) {
                                            return DropdownMenuItem<String>(
                                              value: item.optionCode,
                                              child: Text(item.optionName),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) => viewModel.onStationSelected(value),
                                        ),
                                        const SizedBox(height: 5),
                                         Text("Choose Feeder", style: TextStyle(fontSize: 15, color:Colors.purple[300])),
                                        DropdownButton<String>(
                                          isExpanded: true,
                                          hint: const Text("Select"),
                                          value: viewModel.selectedFeeder,
                                          items: viewModel.feeder.map<DropdownMenuItem<String>>((SubstationModel item) {
                                            return DropdownMenuItem<String>(
                                              value: item.optionCode,
                                              child: Text(item.optionName),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) => viewModel.onListFeederSelected(value),
                                        ),
                                        const SizedBox(height: 5),
                                         Text("Structure Capacity", style: TextStyle(fontSize: 15, color:Colors.purple[300])),
                                        DropdownButton<int>(
                                          isExpanded: true,
                                          hint: const Text("Select"),
                                          value: viewModel.selectedCapacityIndex,
                                          items: viewModel.capacity.asMap().entries.map<DropdownMenuItem<int>>((entry) {
                                            final index = entry.key;
                                            final item = entry.value;
                                            return DropdownMenuItem<int>(
                                              value: index,
                                              child: Text(item.optionName),
                                            );
                                          }).toList(),
                                          onChanged: viewModel.onListCapacitySelected,
                                        ),
                                        const SizedBox(height: 20,),
                                         Text("SAP DTR Structure Code(*)", style: TextStyle(fontSize:15,color:Colors.purple[300]),),
                                        FillTextFormField(
                                          controller: viewModel.sapDTRStructCode,
                                          labelText: '',
                                          isEnable: false,
                                          keyboardType: TextInputType.number,
                                        ),
                                        const SizedBox(height: 20,),
                                         Text("DTR Structure Location LandMark", style: TextStyle(fontSize:15, color:Colors.purple[300] ),),
                                        FillTextFormField(
                                          controller: viewModel.dtrLocatLandMark,
                                          labelText: '',
                                          keyboardType: TextInputType.text,
                                        ),
                                        dropDown(context, "DTR Structure Type(*)","Select", viewModel.selectedDTRType,viewModel.dTRtype,viewModel.onListDTRTypeSelected ),
                                        dropDown(context, "Plinth Type(*)","Select", viewModel.selectedPlintType,viewModel.plintType,viewModel.onListPlintTypeSelected ),
                                        dropDown(context, "AB Switch","Select", viewModel.selectedABSwitch,viewModel.aBSwitch,viewModel.onListABSwitchSelected ),
                                        dropDown(context, "HG Fuse Sets(*)","Select", viewModel.selectedHGFuse,viewModel.hGFuse,viewModel.onListHGFuseSelected ),
                                        dropDown(context, "LT Fuse Sets(*)","Select", viewModel.selectedLTFuseSet,viewModel.lTFuseSet,viewModel.onListLTFuseSelected ),
                                        dropDown(context, "LT Fuse Type(*)","Select", viewModel.selectedLTFuseType,viewModel.lTType,viewModel.onListLTFuseTypeSelected ),
                                        dropDown(context, "Load Pattern","Select", viewModel.selectedLoadPattern,viewModel.loadPattern,viewModel.onListLoadPatternSelected ),
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
                                        const SizedBox(height: 10,),
                                        Column(
                                            children: [
                                              if (viewModel.selectedCapacity != null && viewModel.selectedCapacity != "0")
                                                for (int i = 0; i < int.parse(viewModel.selectedCapacity!); i++)
                                                  Visibility(
                                                    visible: viewModel.selectedCapacity != null && viewModel.selectedCapacity != "0",
                                                    child: Card(
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
                                                        SizedBox(
                                                          width: 150, // Fixed width for all labels
                                                          child: Text(
                                                            "Make",
                                                            style: TextStyle(color: Colors.purple[300]),
                                                          ),
                                                        ),
                                                        Expanded( // Ensure the dropdown has finite width
                                                          child: DropdownButton<String>(
                                                            isExpanded: true,
                                                            hint: const Text("Select Make"),
                                                            value: viewModel.selectedMake,
                                                            items: viewModel.make.map<DropdownMenuItem<String>>((SubstationModel item) {
                                                              return DropdownMenuItem<String>(
                                                                value: item.optionCode,
                                                                child: Text(item.optionName, overflow: TextOverflow.ellipsis,),
                                                              );
                                                            }).toList(),
                                                            onChanged: viewModel.onListMake,
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
                                                      viewModel.selectedDtrCapacity,
                                                      viewModel.dtrCapacity,
                                                      viewModel.onListDtrCapacity,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 150, // Fixed width for all labels
                                                          child:  Text("First time DTR\n "
                                                              "Charged/Energised\n Date", style: TextStyle(color: Colors.purple[300]),),
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
                                                                final formattedDate = "${pickedDate.day.toString().padLeft(2,'0')}/${pickedDate.month.toString().padLeft(2,'0')}/${pickedDate.year}";
                                                                viewModel.first_time_charged_date.text = formattedDate;
                                                              }
                                                            },
                                                            child: IgnorePointer(
                                                              child: TextFormField(
                                                                controller: viewModel.first_time_charged_date,
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
                                                          child:  Text("Serial No ", style: TextStyle(color: Colors.purple[300]),),
                                                        ),
                                                        Expanded(child:
                                                        FillTextFormField(
                                                          controller: viewModel.serialNo,
                                                          labelText: '',
                                                          keyboardType: TextInputType.text,
                                                        )
                                                        ),
                                                      ],
                                                    ),

                                                    const Text("If Serial No. is not available Please click here", style: TextStyle(color: Colors.red,fontSize: 12),),
                                                    Align(
                                                      alignment: Alignment.bottomRight,
                                                      child:
                                                    TextButton(onPressed: viewModel.requestSerialNo,child:const Text("Request Serial No", style: TextStyle(color: Colors.blueAccent), textAlign: TextAlign.right,),),
                                                    ),
                                                    const SizedBox(height: 20,),
                                                    const Text("👉🏻 Please Paint the Serial No on the DTR and capture the photo of DTR", style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                    ),
                                                    const Divider(),
                                                    dtrDrops(
                                                      "Year of Mfg",
                                                      viewModel.selectedYearOfMfg,
                                                      viewModel.yearOfMfg,
                                                      viewModel.onListYearOfMfg,
                                                    ),

                                                    dtrDrops(
                                                      "Phase",
                                                      viewModel.selectedPhase,
                                                      viewModel.phase,
                                                      viewModel.onListPhase,
                                                    ),

                                                    dtrDrops(
                                                      "Ratio",
                                                      viewModel.selectedRatio,
                                                      viewModel.ratio,
                                                      viewModel.onListRatio,
                                                    ),
                                                    const Divider(),
                                                    dtrDrops(
                                                      "Select Type of \n"
                                                          "meter (LV side)",
                                                      viewModel.selectedTypeOfMeter,
                                                      viewModel.typeOfMeter,
                                                      viewModel.onListTypeOfMeter,
                                                    ),
                                                    Row(
                                                      children: [
                                                         SizedBox(
                                                          width: 150, // Fixed width for all labels
                                                          child:  Text("SAP DTR Equp.\n"
                                                              "No(Painted On DTR)", style: TextStyle(color: Colors.purple[300])),
                                                        ),
                                                        Expanded(child:
                                                        FillTextFormField(
                                                          controller: viewModel.sap_dtr,
                                                          labelText: '',
                                                          keyboardType: TextInputType.text,
                                                        )
                                                        ),
                                                      ],
                                                    ),
                                                    const Text("👉🏻 Please Paint the Serial No on the DTR and capture the photo of DTR", style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                    ),
                                                    const SizedBox(height: 10,),
                                                    _buildPlaceholder(viewModel.capturedImage),
                                                    const SizedBox(height: 10,),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor:Colors.deepOrangeAccent,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            //elevation: 15.0,
                                                          ),
                                                          child: const Text("CAPTURE DTR PHOTO", style: TextStyle(color: Colors.white),),
                                                          onPressed: () {
                                                            viewModel.capturePhoto();
                                                          }
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ]
                                       ),
                                      ]
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: viewModel.selectedFilter == "SUB STATION",
                                child:Column(
                                  children: [
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
                                    SizedBox(height: 10,),
                                    Container(
                                      height: 50,
                                      color:Colors.grey[200],
                                      ),
                                  ],
                                ),

                              ),
                              SizedBox(
                                width: double.infinity,
                                child: PrimaryButton(
                                    text: "SUBMIT",
                                    onPressed: () {
                                    viewModel.submitForm();
                                    }
                                ),
                              ),
                            ],
                          ),
                        ]
                    ),
                  ),
                ),
              ),
              if (viewModel.isLoading)
              Positioned.fill(
              child:  Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
              child: CircularProgressIndicator(),
              ),
              ),
              ),
              ]
      ),
              );
            }
        ),
    );
  }
  Widget checkbox(BuildContext context, String title) {
    return Consumer<OnlineDtrViewmodel>(
      builder: (context, viewModel, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: viewModel.selectedFilter == title, // Check if it's the selected option
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

  //Dropdown
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

    //DTR details dropdown
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
  Widget _buildPlaceholder(File? image) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: image == null
            ? const Icon(
          Icons.photo_library,
          size: 50,
          color: Colors.grey,
        )
            : Image.file(
          image!,
          fit: BoxFit.cover, // Adjust fit as needed
          height: 180,
          width: double.infinity,
        ),
      ),
    );
  }
}
