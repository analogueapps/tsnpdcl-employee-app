import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/createOffline_dtr_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';

class SpmCreateOffline extends StatelessWidget {
  const SpmCreateOffline({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => OfflineDtrViewmodel(context: context),
    child: Consumer<OfflineDtrViewmodel>(
    builder: (context, viewModel, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Select Physical Location Of DTR", style: TextStyle(fontSize:15, color:Colors.purple[300]),),
          DropdownButton<String>(
            value: viewModel.selectedPhysicalLocation,
            items: viewModel.listPhysicalLocation.map((location) => DropdownMenuItem<String>(
              value: location,
              child: Text(location),
            )).toList(),
            onChanged: viewModel.onListPhysicalLocation,
          ),
          const SizedBox(height: 10,),
          Text("Select SPM Shed", style: TextStyle(fontSize:15, color:Colors.purple[300]),),
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
                    Align(
                      alignment: Alignment.bottomRight,
                      child:
                      TextButton(
                        onPressed: () => viewModel.requestSerialNo(1),
                        child: const Text(
                          "Request Serial No",
                          style: TextStyle(color: Colors.blueAccent),
                          textAlign: TextAlign.right,
                        ),
                      ),
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
          )
        ],
      );
    }
    ),
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

