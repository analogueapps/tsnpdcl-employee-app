import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/createOnline_dtr_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class CreateDtrOnline extends StatelessWidget {
  static const id= Routes.createOnlineDTR;
  const CreateDtrOnline({super.key});

  @override
  Widget build(BuildContext context) {
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
        actions: const [
          TextButton(onPressed: null,
              child: Text("UPDATE DTR MAKES", style: TextStyle(color: Colors.white),))
        ],
      ),
      body: ChangeNotifierProvider(
        create: (_) => OnlineDtrViewmodel(context:context),
        child: Consumer<OnlineDtrViewmodel>(
            builder: (context, viewModel, child) {
              return SingleChildScrollView(
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
                              Visibility(
                                visible: viewModel.selectedFilter == "STRUCTURE",
                                child:Padding(
                                  padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        dropDown(context, "Select Distribution","Select ", viewModel.selectedDistribution,viewModel.distributions,viewModel.onListDistriSelected ),
                                        dropDown(context, "SS No.","Select ",  viewModel.selectedSSNo,viewModel.ssno,viewModel.onListSSNoSelected ),

                                         Text("Please select feeding details to DTR structure", textAlign: TextAlign.center, style: TextStyle(color:Colors.grey[700]),),

                                        dropDown(context, "Select Circle","Select Circle",  viewModel.selectedCircle,viewModel.circle,viewModel.onListCircleSelected ),
                                        dropDown(context, "Sub Station","Select",  viewModel.selectedStation,viewModel.station,viewModel.onListStationSelected ),
                                        dropDown(context, "Choose Feeder","Select",  viewModel.selectedFeeder,viewModel.feeder,viewModel.onListFeederSelected ),
                                        dropDown(context, "Structure Capacity","Select",  viewModel.selectedCapacity,viewModel.capacity,viewModel.onListCapacitySelected ),

                                        const SizedBox(height: 20,),
                                         Text("SAP DTR Structure Code(*)", style: TextStyle(fontSize:15,color:Colors.purple[300]),),
                                        FillTextFormField(
                                          controller: viewModel.sapDTRStructCode,
                                          labelText: '',
                                          isEnable: false,
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "Please enter USCNO";
                                            } else if (value.length < 8) {
                                              return "Please enter valid USCNO";
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 20,),
                                         Text("DTR Structure Location LandMark", style: TextStyle(fontSize:15, color:Colors.purple[300] ),),
                                        FillTextFormField(
                                          controller: viewModel.dtrLocatLandMark,
                                          labelText: '',
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "Please enter USCNO";
                                            }
                                            return null;
                                          },
                                        ),
                                        dropDown(context, "DTR Structure Type(*)","Select", viewModel.selectedDTRType,viewModel.dTRtype,viewModel.onListDTRTypeSelected ),
                                        dropDown(context, "Plint Type(*)","Select", viewModel.selectedPlintType,viewModel.plintType,viewModel.onListPlintTypeSelected ),
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
                                        // Capacity is selected  displayed Card
                                        Visibility(
                                          visible: viewModel.selectedCapacity != null &&
                                              viewModel.selectedCapacity!.isNotEmpty &&
                                              viewModel.selectedCapacity != "Select",
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
                                                        Expanded( // Ensure the dropdown has finite width
                                                          child: dtrDrops(
                                                            "Make",
                                                            viewModel.selectedCircle,
                                                            viewModel.circle,
                                                            viewModel.onListCircleSelected,
                                                          ),
                                                        ),
                                                        const IconButton(
                                                          onPressed: null,
                                                          icon: Icon(Icons.search, color: CommonColors.pink),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 150, // Fixed width for all labels
                                                          child:  Text("First time DTR\n "
                                                              "Charged/Energised\n date", style: TextStyle(color: Colors.purple[300]),),
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
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return "Please select a date";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                                      ],
                                                    ),
                                                    dtrDrops(
                                                      "Capacity",
                                                      viewModel.selectedCircle,
                                                      viewModel.circle,
                                                      viewModel.onListCircleSelected,
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
                                                          validator: (value) {
                                                            if (value == null || value.isEmpty) {
                                                              return "Please enter Serial No";
                                                            }
                                                            return null;
                                                          },
                                                        )
                                                        ),
                                                      ],
                                                    ),

                                                    const Text("If Serial No. is not available Please click here", style: TextStyle(color: Colors.red,fontSize: 12),),
                                                    const Align(
                                                      alignment: Alignment.bottomRight,
                                                      child:
                                                    Text("Request Serial No", style: TextStyle(color: Colors.blueAccent), textAlign: TextAlign.right,),
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
                                                      viewModel.selectedCircle,
                                                      viewModel.circle,
                                                      viewModel.onListCircleSelected,
                                                    ),

                                                    dtrDrops(
                                                      "Phase",
                                                      viewModel.selectedCircle,
                                                      viewModel.circle,
                                                      viewModel.onListCircleSelected,
                                                    ),

                                                    dtrDrops(
                                                      "Ratio",
                                                      viewModel.selectedCircle,
                                                      viewModel.circle,
                                                      viewModel.onListCircleSelected,
                                                    ),
                                                    const Divider(),
                                                    dtrDrops(
                                                      "Select Type of \n"
                                                          "meter (LV side)",
                                                      viewModel.selectedCircle,
                                                      viewModel.circle,
                                                      viewModel.onListCircleSelected,
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
                                                          validator: (value) {
                                                            if (value == null || value.isEmpty) {
                                                              return "Please enter sap dtr";
                                                            }
                                                            return null;
                                                          },
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
                                                    _buildPlaceholder(),
                                                    const SizedBox(height: 10,),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            //backgroundColor: CommonColors.colorPrimary,
                                                            backgroundColor:Colors.deepOrangeAccent,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            //elevation: 15.0,
                                                          ),
                                                          child: const Text("CAPTURE DTR PHOTO", style: TextStyle(color: Colors.white),),
                                                          onPressed: () {

                                                          }
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: PrimaryButton(
                                              text: "SUBMIT",
                                              onPressed: () {

                                              }
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
                              )
                            ],
                          ),
                        ]
                    ),
                  ),
                ),
              );
            }
        ),
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
                  child: Text(item),
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
