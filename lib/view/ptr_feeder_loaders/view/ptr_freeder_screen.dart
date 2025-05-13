import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/lc_master_ss_list.dart';
import 'package:tsnpdcl_employee/view/ptr_feeder_loaders/viewmodel/ptr_feeder_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class PtrFeederScreen extends StatelessWidget {
  static const id = Routes.ptrFeederScreen;

  const PtrFeederScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CommonColors.colorPrimary,
          title: const Text(
            GlobalConstants.ptrFeederLoaders,
            style:  TextStyle(
                color: Colors.white,
                fontSize: toolbarTitleSize,
                fontWeight: FontWeight.w700),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: ChangeNotifierProvider(
            create: (_) => PtrFeederViewmodel(context: context),
            child: Consumer<PtrFeederViewmodel>(
                builder: (context, viewModel, child) {
              return viewModel.isLoading?
              const Center(child:CircularProgressIndicator()):Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                  height: 350,
                  child:Card(
                  child: Padding(padding: EdgeInsets.all(10),
                    child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("SELECT SUBSTATION", style:TextStyle(color: Colors.red[900]) ,),
                      const SizedBox(
                        height: 10,
                      ),
                          DropdownButtonFormField<String>(
                          value: viewModel.selectedSs,
                          hint: const Text(""),
                          isExpanded: true,
                          items: viewModel.subStationList.map((LcMasterSsList item) {
                            return DropdownMenuItem<String>(
                              value: item.optionId,
                              child: Text(item.optionName??""),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            viewModel.updateSs(newValue);
                            print(newValue);
                          },
                        ),
                      const SizedBox(height: 10,),
                       TextButton(
                         style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                        ),
                        onPressed: () {
                          viewModel.pickDateFromDateTimePicker(
                              context);
                        },
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                             const Icon(
                                Icons.calendar_month_outlined, size: 25, color: Colors.black,),
                             const SizedBox(
                              width: 8,
                            ),
                            Text(
                              viewModel.pickedDate==''|| viewModel.pickedDate=="null/null/null"?"CHOOSE DATE": viewModel.pickedDate,
                              style:  TextStyle(
                                  color: Colors.red[900]),
                            )
                          ],
                        ),
                      ) ,
                      SizedBox(height: 10,),
                       Text("SELECT LOAD HOURS", style:TextStyle(color: Colors.red[900]) ,),
                      const SizedBox(
                        height: 10,
                      ),
                    DropdownButtonFormField<String>(
                      value: viewModel.selectedLoadHour, // Ensure this is a String and one of the options in loadHours
                      hint: const Text("SELECT LOAD HOUR"),
                      isExpanded: true,
                      items: viewModel.loadHours.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        viewModel.selectedLoadHour = newValue; // Or call a method like viewModel.updateLoadHour(newValue)

                      },
                    ),
                      const SizedBox(height:10 ,),
                      SizedBox(
                        width: double.infinity,
                        child:
                        PrimaryButton(
                            text: "GET DETAILS",
                            onPressed: (){
                              viewModel.getPtrFeederSS(viewModel.selectedSs!);
                            }
                        ),
                      ),
                    ],
                  ),
                ),
                ),
                ),
              );
            })));
  }
}
